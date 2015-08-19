//
//  CoursesViewController.swift
//  NerdFeed
//
//  Created by Michael Borgmann on 15/06/15.
//  Copyright (c) 2015 Michael Borgmann. All rights reserved.
//

import UIKit

class CoursesViewController: UITableViewController, NSURLSessionDataDelegate {

    var session: NSURLSession?
    var courses: NSArray?
    var webViewController: WebViewController?

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nil, bundle: nil)
    }

    override convenience init(style: UITableViewStyle) {
        self.init(nibName: nil, bundle: nil)
        
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        session = NSURLSession(configuration: config, delegate: self, delegateQueue: nil)
        navigationItem.title = "Courses"
        fetchFeed()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func fetchFeed() {
        //let requestString = "https://bookapi.bignerdranch.com/private/courses.json"
        let requestString = "http://bookapi.bignerdranch.com/courses.json"
        let url = NSURL(string: requestString)
        let req = NSURLRequest(URL: url!)
        
        let dataTask = session!.dataTaskWithRequest(req, completionHandler: {
            (data: NSData!, response: NSURLResponse!, error: NSError!) in
            let jsonObject = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as! NSDictionary
            self.courses = jsonObject["courses"] as? NSArray
            print(self.courses)
            dispatch_async(dispatch_get_main_queue()) { self.tableView.reloadData() }
        })
        dataTask.resume()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (courses != nil) ? courses!.count : 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath) as! UITableViewCell
        let course = courses![indexPath.row] as! NSDictionary
        cell.textLabel?.text = course["title"] as? String
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let course = courses![indexPath.row] as! NSDictionary
        let url = NSURL(string: course["url"] as! String)
        
        webViewController!.title = (course["title"] as! String)
        webViewController!.URL = url
        
        if splitViewController == nil {
            navigationController?.pushViewController(webViewController!, animated: true)
        }
    }
    
    func URLSession(session: NSURLSession, didReceiveChallenge challenge: NSURLAuthenticationChallenge, completionHandler: (NSURLSessionAuthChallengeDisposition, NSURLCredential!) -> Void) {
        let cred = NSURLCredential(user: "BigNerdRanch",
            password: "AchieveNerdvana", persistence: .ForSession)
        completionHandler(.UseCredential, cred)
    }

}
