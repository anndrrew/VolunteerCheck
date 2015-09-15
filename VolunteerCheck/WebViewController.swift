//
//  WebViewController.swift
//  VolunteerCheck
//
//  Created by Andrew Brissenden on 31/08/2015.
//  Copyright (c) 2015 Andrew Brissenden. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var stop: UIBarButtonItem!
    @IBOutlet weak var doRefresh: UIBarButtonItem!
    @IBOutlet weak var goBack: UIBarButtonItem!
    @IBOutlet weak var goForward: UIBarButtonItem!
    
    var urlpath = "http://willconsider.org/basic/web/"
    
    func loadAddressURL(){
        let requesturl = NSURL(string: urlpath)
        let request = NSURLRequest(URL: requesturl!)
        webView.loadRequest(request)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadAddressURL()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation
    @IBAction func doRefresh(AnyObject) {
    webView.reload()
    }
    
    @IBAction func goBack(AnyObject) {
    webView.goBack()
    }
    
    @IBAction func goForward(AnyObject) {
    webView.goForward()
    }
    
    @IBAction func stop(AnyObject) {
    webView.stopLoading()
    }

    
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
