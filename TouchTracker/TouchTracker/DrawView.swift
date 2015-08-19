//
//  DrawView.swift
//  TouchTracker
//
//  Created by Michael Borgmann on 08/06/15.
//  Copyright (c) 2015 Michael Borgmann. All rights reserved.
//

import UIKit

class DrawView: UIView, UIGestureRecognizerDelegate {
    
    private var linesInProgress = [NSValue: Line]()
    private var finishedLines = [Line]()

    weak var selectedLine: Line?
    var moveRecognizer: UIPanGestureRecognizer?
    var threeFingerRecognizer: UISwipeGestureRecognizer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.grayColor()
        multipleTouchEnabled = true
        
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: "doubleTap:")
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.delaysTouchesBegan = true
        addGestureRecognizer(doubleTapRecognizer)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "tap:")
        tapRecognizer.delaysTouchesBegan = true
        tapRecognizer.requireGestureRecognizerToFail(doubleTapRecognizer)
        addGestureRecognizer(tapRecognizer)
        
        let pressRecognizer = UILongPressGestureRecognizer(target: self, action: "longPress:")
        addGestureRecognizer(pressRecognizer)
        
        moveRecognizer = UIPanGestureRecognizer(target: self, action: "moveLine:")
        moveRecognizer!.delegate = self
        moveRecognizer!.cancelsTouchesInView = false
        addGestureRecognizer(moveRecognizer!)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    func strokeLine(line: Line) {
        let bp = UIBezierPath()
        bp.lineWidth = 10
        bp.lineCapStyle = kCGLineCapRound
        
        bp.moveToPoint(line.begin)
        bp.addLineToPoint(line.end)
        bp.stroke()
    }
    
    func moveLine(gr: UIPanGestureRecognizer) {
        if var selectedLine = selectedLine {
            if gr.state == .Changed {
                let translation = gr.translationInView(self)
                
                var begin = selectedLine.begin
                var end = selectedLine.end
                begin.x += translation.x
                begin.y += translation.y
                end.x += translation.x
                end.y += translation.y
                
                selectedLine.begin = begin
                selectedLine.end = end
                
                setNeedsDisplay()
                
                gr.setTranslation(CGPointZero, inView: self)
            }
        }
    }
    
    override func drawRect(rect: CGRect) {
        UIColor.blackColor().set()
        for line in finishedLines {
            strokeLine(line)
        }
        
        UIColor.redColor().set()
        for (_, line) in linesInProgress {
            strokeLine(line)
        }
        
        if let selectedLine = selectedLine {
            UIColor.greenColor().set()
            strokeLine(selectedLine)
        }
    }
    
    func lineAtPoint(p: CGPoint) -> Line? {
        for line in finishedLines {
            let start = line.begin
            let end = line.end
            
            for var t: CGFloat = 0.0; t <= 1.0; t += 0.05 {
                let x = start.x + t * (end.x - start.x)
                let y = start.y + t * (end.y - start.y)
                
                if (hypot(x - p.x, y - p.y) < 20.0) {
                    return line
                }
            }
        }
        return nil
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        NSLog("%@", __FUNCTION__)
        
        for t in touches {
            if let t = t as? UITouch {
                let location = t.locationInView(self)

                let line = Line(begin: location, end: location)
                //line.begin = location
                //line.end = location
            
                let key = NSValue(nonretainedObject: t)
                linesInProgress[key] = line
                }
            }
        
        setNeedsDisplay()
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        NSLog("%@", __FUNCTION__)
        
        for t in touches {
            if let t = t as? UITouch {
                let key = NSValue(nonretainedObject: t)
                
                if let line = linesInProgress[key] {
                    line.end = t.locationInView(self)
                }
            }
        }
        
        setNeedsDisplay()
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        NSLog("%@", __FUNCTION__)
        
        for t in touches {
            let key = NSValue(nonretainedObject: t)
            
            if let line = linesInProgress[key] {
                finishedLines += [line]
            }
            linesInProgress.removeValueForKey(key)
        }
        
        setNeedsDisplay()
    }
    
    override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
        NSLog("%@", __FUNCTION__)
        
        for t in touches {
            let key = NSValue(nonretainedObject: t)
            linesInProgress.removeValueForKey(key)
        }
        
        setNeedsDisplay()
    }
    
    func longPress(gr: UIGestureRecognizer) {
        if gr.state == .Began {
            let point = gr.locationInView(self)
            selectedLine = lineAtPoint(point)
            
            if selectedLine != nil {
                linesInProgress.removeAll(keepCapacity: true)
            }
            
        } else if gr.state == .Ended {
            selectedLine = nil
        }
        
        setNeedsDisplay()
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == moveRecognizer {
            return true
        }
        return false
    }
    
    func tap(gr: UITapGestureRecognizer) {
        println("Recognized tap")
        
        let point = gr.locationInView(self)
        selectedLine = lineAtPoint(point)
        
        if selectedLine != nil {
            becomeFirstResponder()
            
            let menu = UIMenuController.sharedMenuController()
            let deleteItem = UIMenuItem(title: "Delete", action: "deleteLine:")
            menu.menuItems = [deleteItem]
            menu.setTargetRect(CGRectMake(point.x, point.y, 2, 2), inView: self)
            menu.setMenuVisible(true, animated: true)
        } else {
            UIMenuController.sharedMenuController().setMenuVisible(false, animated: true)
        }
        
        setNeedsDisplay()
    }
    
    func singleTap(gesture: UITapGestureRecognizer) {
        println("Recognized a single tap")
        
        let point = gesture.locationInView(self)
        selectedLine = lineAtPoint(point)
        
        if selectedLine != nil {
            becomeFirstResponder()
            
            let menu = UIMenuController.sharedMenuController()
            let deleteItem = [UIMenuItem(title: "Delete", action: "deleteLine:")]
            menu.menuItems = deleteItem
            menu.setTargetRect(CGRectMake(point.x, point.y, 2, 2), inView: self)
            menu.setMenuVisible(true, animated: true)
        }
        else {
            UIMenuController.sharedMenuController().setMenuVisible(false, animated: true)
        }
        
        setNeedsDisplay()
    }
    
    func doubleTap(gr: UITapGestureRecognizer) {
        println("Recognized Double Tap")
        linesInProgress.removeAll(keepCapacity: true)
        finishedLines.removeAll(keepCapacity: true)
        setNeedsDisplay()
    }
}
