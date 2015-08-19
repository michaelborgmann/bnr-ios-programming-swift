//
//  DrawViewController.swift
//  TouchTracker
//
//  Created by Michael Borgmann on 08/06/15.
//  Copyright (c) 2015 Michael Borgmann. All rights reserved.
//

import UIKit

class DrawViewController: UIViewController {

    override func loadView() {
        view = DrawView(frame: CGRectZero)
    }
    
}
