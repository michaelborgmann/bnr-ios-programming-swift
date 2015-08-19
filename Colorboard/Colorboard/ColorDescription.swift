//
//  ColorDescription.swift
//  Colorboard
//
//  Created by Michael Borgmann on 17/06/15.
//  Copyright (c) 2015 Michael Borgmann. All rights reserved.
//

import UIKit

class ColorDescription: NSObject {
   
    var color: UIColor
    var name: String
    
    override init() {
        color = UIColor(red: 0, green: 0, blue: 1, alpha: 1)
        name = "Blue"
    }
    
}
