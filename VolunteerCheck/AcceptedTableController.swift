//
//  AcceptedTableController.swift
//  VolunteerCheck
//
//  Created by Andrew Brissenden on 14/09/2015.
//  Copyright (c) 2015 Andrew Brissenden. All rights reserved.
//

import UIKit

class AcceptedTableController: UITableViewController {
    
    // MARK: Properties
    var rosterModel = RosterModel()
    
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        // Force scene to reload everytime the tab is in view
        tableView.reloadData()
    }
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Add Model from RosterTabController
        let tbvc = self.tabBarController  as! RosterTabController
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
        
        header.programNameLabel.text = rosterModel.getAcceptedRosterEvents()[section].getProgramName()
        header.eventDateLabel.text = rosterModel.getAcceptedRosterEvents()[section].getEventDate()
        header.eventStartLabel.text = rosterModel.getAcceptedRosterEvents()[section].getStartTime()
        header.eventEndLabel.text = rosterModel.getAcceptedRosterEvents()[section].getEndTime()
        
        return header
    }
    
    

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        // Return the number of sections.
        return rosterModel.getAcceptedRosterEvents().count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        var rows = rosterModel.getAcceptedRosterEvents()[section].getEventJobs().count
        
        // Return the number of rows in the section.
        return rows
    }
    
    
    // Configure Rows to print on screen
    override func tableView(tableView: UITableView, cellForRowAtIndexPath
        indexPath: NSIndexPath) -> UITableViewCell
    {
        let cellIdentifier = "AcceptedCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! EventCell
        
        // Fetches the appropriate Roster Event for the data source layout.
        let rosterEvent = rosterModel.getAcceptedRosterEvents()[indexPath.section].getEventJobs()[indexPath.row]
        cell.jobNameLabel.text = rosterEvent.getAreaName()
        cell.areaDescriptionLabel.text = rosterEvent.getInformation()
        
        return cell
    }
}
