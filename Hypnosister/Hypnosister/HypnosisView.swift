//
//  HypnosisView.swift
//  Hypnosister
//
//  Created by Michael Borgmann on 02/06/15.
//  Copyright (c) 2015 Michael Borgmann. All rights reserved.
//

import UIKit

class HypnosisView: UIView {

    private var circleColor: UIColor = UIColor.lightGrayColor() {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        let bounds = self.bounds
        
        var center = CGPoint()
        center.x = bounds.origin.x + bounds.size.width / 2.0
        center.y = bounds.origin.y + bounds.size.height / 2.0
        
        var maxRadius = hypotf(Float(bounds.size.width), Float(bounds.size.height)) / 2.0
        let path = UIBezierPath()
        
        for var currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20 {
            path.moveToPoint(CGPointMake(center.x + CGFloat(currentRadius), center.y))
            path.addArcWithCenter(center, radius: CGFloat(currentRadius), startAngle: 0.0, endAngle: CGFloat(M_PI) * 2.0, clockwise: true)
        }
        
        path.lineWidth = 10
        self.circleColor.setStroke()
        path.stroke()
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        print("Touch began on \(self)")
        
        func randomNumber() -> Float { return Float(arc4random() % 100) / 100.0 }
        let red = randomNumber()
        let green = randomNumber()
        let blue = randomNumber()
        
        let randomColor = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1.0)
        
        self.circleColor = randomColor
    }
}
