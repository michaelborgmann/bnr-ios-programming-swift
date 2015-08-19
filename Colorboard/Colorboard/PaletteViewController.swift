//
//  PaletteViewController.swift
//  Colorboard
//
//  Created by Michael Borgmann on 17/06/15.
//  Copyright (c) 2015 Michael Borgmann. All rights reserved.
//

import UIKit

class PaletteViewController: UITableViewController {

    var colors = [ColorDescription]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colors.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath) as!UITableViewCell
        
        let color = colors[indexPath.row]
        cell.textLabel?.text = color.name
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "NewColor" {
            
            let color = ColorDescription()
            colors.append(color)
            
            let nc = segue.destinationViewController as? UINavigationController
            let mvc = nc?.topViewController as? ColorViewController
            mvc?.colorDescription = color
        } else if (segue.identifier == "ExistingColor") {
            let cell = sender as? UITableViewCell
            let ip = tableView.indexPathForCell((sender as? UITableViewCell)!)
            let color = colors[ip!.row]
            let cvc = segue.destinationViewController as? ColorViewController
            cvc!.colorDescription = color
            cvc!.existingColor = true
        }
    }
    
}
