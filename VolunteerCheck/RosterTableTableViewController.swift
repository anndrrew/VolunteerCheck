//
//  RosterTableTableViewController.swift
//  VolunteerCheck
//
//  Created by Andrew Brissenden on 31/08/2015.
//  Copyright (c) 2015 Andrew Brissenden. All rights reserved.
//

import UIKit

class RosterTableTableViewController: UITableViewController {
    
    // MARK: Properties
    var rosterModel = RosterModel()
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Add Model from RosterTabController
        let tbvc = self.tabBarController as! RosterTabController
        rosterModel = tbvc.rosterModel

        self.tableView.sectionHeaderHeight = 80
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView
    {
        let cellIdentifier = "EventHeaderCell"
        
        var header = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! EventHeaderCell
        
        header.programNameLabel.text = rosterModel.getRosterEvents()[section].getProgramName()
        header.eventDateLabel.text = rosterModel.getRosterEvents()[section].getEventDate()
        header.eventStartLabel.text = rosterModel.getRosterEvents()[section].getStartTime()
        header.eventEndLabel.text = rosterModel.getRosterEvents()[section].getEndTime()
        
        return header
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        // Return the number of sections.
        return rosterModel.getRosterEvents().count
    }

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        var rows = rosterModel.getRosterEvents()[section].getEventJobs().count
        
        // Return the number of rows in the section.
        return rows
    }
    

    // Configure Rows to print on screen
    override func tableView(tableView: UITableView, cellForRowAtIndexPath
        indexPath: NSIndexPath) -> UITableViewCell
    {
        let cellIdentifier = "EventCell"
            
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! EventCell
            
        // Fetches the appropriate Roster Event for the data source layout.
        let rosterEvent = rosterModel.getRosterEvents()[indexPath.section].getEventJobs()[indexPath.row]
        cell.jobNameLabel.text = rosterEvent.getAreaName()
        cell.areaDescriptionLabel.text = rosterEvent.getInformation()
        
        cell.rejectBtn.tag = indexPath.row
        cell.rejectBtn.tag2 = indexPath.section
        cell.rejectBtn.addTarget(self, action: "rejectJobOffer:", forControlEvents: .TouchUpInside)
        
        cell.acceptBtn.tag = indexPath.row
        cell.acceptBtn.tag2 = indexPath.section
        cell.acceptBtn.addTarget(self, action: "acceptJobOffer:", forControlEvents: .TouchUpInside)
            
        return cell
    }
    

    @IBAction func acceptJobOffer(sender: ListButton)
    {
        // Add Selected Event to the Accepted Jobs Array
        if(rosterModel.addAcceptedRosterEventJob(rosterModel.getRosterEvents()[sender.tag2!], newJob: rosterModel.getRosterEvents()[sender.tag2!].getEventJobs()[sender.tag]))
        {
            // If successful remove from current roster list
            rosterModel.removeRosterEventJob(rosterModel.getRosterEvents()[sender.tag2!], currJob: rosterModel.getRosterEvents()[sender.tag2!].getEventJobs()[sender.tag])
        }
        
        (tabBarController as! RosterTabController).rosterModel = rosterModel
        
        tableView.reloadData()
        
    }
    
    @IBAction func rejectJobOffer(sender: ListButton) {
        // Add Selected Event to the Rejected Jobs Array
        if(rosterModel.addRejectedRosterEventJob(rosterModel.getRosterEvents()[sender.tag2!], newJob: rosterModel.getRosterEvents()[sender.tag2!].getEventJobs()[sender.tag]))
        {
            // If successful remove from current roster list
            rosterModel.removeRosterEventJob(rosterModel.getRosterEvents()[sender.tag2!], currJob: rosterModel.getRosterEvents()[sender.tag2!].getEventJobs()[sender.tag])
        }
        
//        // Push updated model back to tab controller
//        let tbvc = self.tabBarController  as! RosterTabController
//        tbvc.rosterModel = rosterModel
        
        tableView.reloadData()
    }
    
    
    
    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
//    {
//        self.performSegueWithIdentifier("showView", sender: self)
//        
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
