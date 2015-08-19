//
//  ColorViewController.swift
//  Colorboard
//
//  Created by Michael Borgmann on 17/06/15.
//  Copyright (c) 2015 Michael Borgmann. All rights reserved.
//

import UIKit

class ColorViewController: UIViewController {

    @IBOutlet weak var textfield: UITextField?
    @IBOutlet weak var redSlider: UISlider?
    @IBOutlet weak var greenSlider: UISlider?
    @IBOutlet weak var blueSlider: UISlider?
    
    var existingColor: Bool?
    var colorDescription: ColorDescription?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let color = colorDescription?.color
        var red = CGFloat(0)
        var blue = CGFloat(0)
        var green = CGFloat(0)
        var alpha = CGFloat(0)
        color!.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        redSlider!.value = Float(red)
        greenSlider!.value = Float(green)
        blueSlider!.value = Float(blue)
        
        view.backgroundColor = color
        textfield?.text = self.colorDescription?.name
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
     
        if (existingColor != nil) {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.colorDescription!.name = textfield!.text
        self.colorDescription!.color = view.backgroundColor!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func dismiss(sender: UIBarButtonItem) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func changeColor(sender: UISlider) {
        let red = CGFloat(redSlider!.value)
        let green = CGFloat(greenSlider!.value)
        let blue = CGFloat(blueSlider!.value)
        let newColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        view.backgroundColor = newColor
    }

}
