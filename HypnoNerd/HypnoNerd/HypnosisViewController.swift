//
//  HypnosisViewController.swift
//  HypnoNerd
//
//  Created by Michael Borgmann on 03/06/15.
//  Copyright (c) 2015 Michael Borgmann. All rights reserved.
//

import UIKit

class HypnosisViewController: UIViewController, UITextFieldDelegate {

    init() {
        super.init(nibName: "HypnosisViewController", bundle: nil)
        self.tabBarItem.title = "Hypnotize"
        let image = UIImage(named: "Hypno.png")
        tabBarItem.image = image
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let frame = UIScreen.mainScreen().bounds
        let backgroundView = HypnosisView(frame: frame)
        
        let textFieldRect = CGRectMake(40, 70, 240, 30)
        let textField = UITextField(frame: textFieldRect)
        
        textField.borderStyle = .RoundedRect
        textField.placeholder = "Hypnotize me"
        textField.returnKeyType = UIReturnKeyType.Done
        textField.delegate = self
        
        backgroundView.addSubview(textField)
        view = backgroundView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("HypnosisViewController loaded")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        drawHypnoticMessage(textField.text)
        textField.text = ""
        textField.resignFirstResponder()
        return true
    }

    func drawHypnoticMessage(message: NSString) {
        for _ in 0..<20 {
            let messageLabel = UILabel()
            
            messageLabel.backgroundColor = UIColor.clearColor()
            messageLabel.textColor = UIColor.whiteColor()
            messageLabel.text = message as String
            messageLabel.sizeToFit()
            
            let width = UInt32(self.view.bounds.size.width - messageLabel.bounds.size.width)
            let x = arc4random_uniform(width)
            
            let height = UInt32(self.view.bounds.size.height - messageLabel.bounds.size.height)
            let y = arc4random_uniform(height)
            
            messageLabel.frame.origin = CGPoint(x: CGFloat(UInt(x)), y: CGFloat(UInt(y)))
            
            self.view.addSubview(messageLabel)
            
            var motionEffect = UIInterpolatingMotionEffect(keyPath: "center.x", type: .TiltAlongHorizontalAxis)
            motionEffect.minimumRelativeValue = -25
            motionEffect.maximumRelativeValue = 25
            messageLabel.addMotionEffect(motionEffect)
            
            motionEffect = UIInterpolatingMotionEffect(keyPath: "center.y", type: .TiltAlongVerticalAxis)
            motionEffect.minimumRelativeValue = -25
            motionEffect.maximumRelativeValue = 25
            messageLabel.addMotionEffect(motionEffect)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
