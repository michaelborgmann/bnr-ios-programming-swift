//
//  ReminderViewController.swift
//  HypnoNerd
//
//  Created by Michael Borgmann on 03/06/15.
//  Copyright (c) 2015 Michael Borgmann. All rights reserved.
//

import UIKit

class ReminderViewController: UIViewController {

    @IBOutlet var datePicker: UIDatePicker?

    init() {
        super.init(nibName: "ReminderViewController", bundle: nil)
        self.tabBarItem.title = "Reminder";
        let image = UIImage(named: "Time.png")
        self.tabBarItem.image = image;
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("ReminderViewController loaded")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        datePicker!.minimumDate = NSDate(timeIntervalSinceNow: 60)
    }

    @IBAction internal func addReminder(sender: AnyObject) {
        let date = datePicker!.date
        println("Setting a reminder for %@", date)
        let note = UILocalNotification()
        note.alertBody = "Hypnotize me!"
        note.fireDate = date
        UIApplication.sharedApplication().scheduleLocalNotification(note)
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
