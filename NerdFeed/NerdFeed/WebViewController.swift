//
//  WebViewController.swift
//  NerdFeed
//
//  Created by Michael Borgmann on 15/06/15.
//  Copyright (c) 2015 Michael Borgmann. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UISplitViewControllerDelegate {

    var URL: NSURL? {
        get {
            return self.URL
        }
        set (newUrl) {
            if newUrl != nil {
                let req = NSURLRequest(URL: newUrl!)
                (view as! UIWebView).loadRequest(req)
            }
        }
    }
    
    override func loadView() {
        let webView = UIWebView()
        webView.scalesPageToFit = true
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
    
    func goBack(sender: UIBarButtonItem) {
        println("Back button clicked")
        (view as! UIWebView).goBack()
    }
    
    func goForward(sender: UIBarButtonItem) {
        println("Forward button clicked")
        (view as! UIWebView).goForward()
    }

    func splitViewController(svc: UISplitViewController, willHideViewController aViewController: UIViewController, withBarButtonItem barButtonItem: UIBarButtonItem, forPopoverController pc: UIPopoverController) {
        barButtonItem.title = "Courses"
        navigationItem.leftBarButtonItem = barButtonItem
    }

    func splitViewController(svc: UISplitViewController, willShowViewController aViewController: UIViewController, invalidatingBarButtonItem barButtonItem: UIBarButtonItem) {
        if barButtonItem == navigationItem.leftBarButtonItem {
            navigationItem.leftBarButtonItem = nil
        }
    }

}