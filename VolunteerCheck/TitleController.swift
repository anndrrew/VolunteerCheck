//
//  TitleController.swift
//  VolunteerCheck
//
//  Created by Andrew Brissenden on 4/09/2015.
//  Copyright (c) 2015 Andrew Brissenden. All rights reserved.
//

import UIKit

class TitleController: UIViewController {
    // MARK: properties
    var rosterModel = RosterModel()
    var currVolunteer: Volunteer?
    @IBOutlet weak var loadingLabel: UILabel!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    
    // Once view has appeared check log in and handle segue
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        if(userLoggedIn()){
            
            rosterModel = self.getVolunteerData(rosterModel)
            
        } else {
            //
            
            self.logInUser()
            
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Check if User is logged in
    func userLoggedIn() -> Bool{
        // Load test volunteer data from persistent memory
        currVolunteer = loadTestVolunteer()
        
        // Create formated string to send on POST request
        let postString = "id=" + currVolunteer!.id + "&email=" + currVolunteer!.email
        
        // If login redentials match return true
        DataManager.sendLoginPostRequest(postString)
        
        return true
    }
    
    
    // Send Saved Volunteer details to the server to validate
    func remoteCheckVolCredentials(testVolunteer: Volunteer) -> Bool
    {
        
        return true
    }
    
    
    // MARK: - Action
    @IBAction func unwindToTitle(sender: UIStoryboardSegue)
    {
        if let sourceViewController = sender.sourceViewController as? ViewController{
            
            currVolunteer = sourceViewController.testVolunteer
            
            println(currVolunteer!.id)
            
            saveTestVolunteer()
        }
        
    }
    
    
    // MARK: - Navigation
    
    // Segue to User Log in Screen
    func logInUser(){
        
        self.performSegueWithIdentifier("goLogInSegue", sender: self)
        
    }
    
    
    // Segue to User Roster Screen
    func goToRoster(){
        
        println("Segue triggered")
        self.performSegueWithIdentifier("goToRosterSegue", sender: self)
        
    }
    
    
    // Prepare data modal hand off to next Scene.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        println("Prepare for segue run.")
        
        if (segue.identifier == "goToRosterSegue"){
            
            let targetController = segue.destinationViewController as! RosterTabController
            
            targetController.rosterModel = rosterModel
        }
    }
    
    
    // MARK: NSCoding
    
    func saveTestVolunteer(){
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(currVolunteer!, toFile: Volunteer.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save Volunteer Details...")
        }
    }
    
    func loadTestVolunteer() -> Volunteer?{
        
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Volunteer.ArchiveURL.path!) as? Volunteer
        
    }
    
    
    
    
    // Get Volunteer Roster From Server
    func getVolunteerData(rosterModel: RosterModel) ->RosterModel{
        
        DataManager.getRosterWithSuccess { (volunteersData) -> Void in
            let json = JSON(data: volunteersData)
            
            // Get Array of values from JSON Object
            if let rosterArray = json["vol_roster"].array{
                
                for rosterList in rosterArray{
                    if let newRoster = rosterList["new_roster"].array{
                        
                        //
                        for rosterDict in newRoster{
                            var volId: String? = rosterDict["volId"].string
                            var programName: String? = rosterDict["programName"].string
                            var date: String? = rosterDict["date"].string
                            var startTime: String? = rosterDict["startTime"].string
                            var endTime: String? = rosterDict["endTime"].string
                            
                            // Create temp Roster Event Object
                            var event = RosterEvent(volId: volId, programName: programName, date: date, startTime: startTime, endTime: endTime)
                            
                            // Add New Roster event to events array
                            rosterModel.addRosterEvent(event)
                            
                            // Add Jobs to Jobs array ascociated with the event
                            if let jobArray = rosterDict["areaNames"].array{
                                
                                for jobDict in jobArray{
                                    var areaName: String? = jobDict["areaName"].string
                                    var confirmBy: String? = jobDict["confirmBy"].string
                                    var reminder: String? = jobDict["reminder"].string
                                    var information: String? = jobDict["description"].string
                                    
                                    // Create temp Event job object
                                    var job = EventJob(areaName: areaName,  confirmBy: confirmBy, reminder: reminder, information: information)
                                    
                                    // Add new Job to Jobs Array
                                    rosterModel.getRosterEvent(programName!, eventDate: date!).addEventJob(job)
                                }
                            }
                            // DEBUG: Print out Roster details
                            println(rosterModel.getRosterEvents())
                        }
                        
                    }
                    if let acceptedRoster = rosterList["accepted_roster"].array{
                        
                        //
                        for rosterDict in acceptedRoster{
                            var volId: String? = rosterDict["volId"].string
                            var programName: String? = rosterDict["programName"].string
                            var date: String? = rosterDict["date"].string
                            var startTime: String? = rosterDict["startTime"].string
                            var endTime: String? = rosterDict["endTime"].string
                            
                            // Create temp Roster Event Object
                            var event = RosterEvent(volId: volId, programName: programName, date: date, startTime: startTime, endTime: endTime)
                            
                            // Add New Roster event to events array
                            rosterModel.addAcceptedRosterEvent(event)
                            
                            // Add Jobs to Jobs array ascociated with the event
                            if let jobArray = rosterDict["areaNames"].array{
                                
                                for jobDict in jobArray{
                                    var areaName: String? = jobDict["areaName"].string
                                    var confirmBy: String? = jobDict["confirmBy"].string
                                    var reminder: String? = jobDict["reminder"].string
                                    var information: String? = jobDict["description"].string
                                    
                                    // Create temp Event job object
                                    var job = EventJob(areaName: areaName,  confirmBy: confirmBy, reminder: reminder, information: information)
                                    
                                    // Add new Job to Jobs Array
                                    rosterModel.getAcceptedRosterEvent(programName!, eventDate: date!).addEventJob(job)
                                }
                            }
                            // DEBUG: Print out Roster details
                            println(rosterModel.getAcceptedRosterEvents())
                        }
                        
                    }
                    if let rejectedRoster = rosterList["rejected_roster"].array{
                        
                        //
                        for rosterDict in rejectedRoster{
                            var volId: String? = rosterDict["volId"].string
                            var programName: String? = rosterDict["programName"].string
                            var date: String? = rosterDict["date"].string
                            var startTime: String? = rosterDict["startTime"].string
                            var endTime: String? = rosterDict["endTime"].string
                            
                            // Create temp Roster Event Object
                            var event = RosterEvent(volId: volId, programName: programName, date: date, startTime: startTime, endTime: endTime)
                            
                            // Add New Roster event to events array
                            rosterModel.addRejectedRosterEvent(event)
                            
                            // Add Jobs to Jobs array ascociated with the event
                            if let jobArray = rosterDict["areaNames"].array{
                                
                                for jobDict in jobArray{
                                    var areaName: String? = jobDict["areaName"].string
                                    var confirmBy: String? = jobDict["confirmBy"].string
                                    var reminder: String? = jobDict["reminder"].string
                                    var information: String? = jobDict["description"].string
                                    
                                    // Create temp Event job object
                                    var job = EventJob(areaName: areaName,  confirmBy: confirmBy, reminder: reminder, information: information)
                                    
                                    // Add new Job to Jobs Array
                                    rosterModel.getRejectedRosterEvent(programName!, eventDate: date!).addEventJob(job)
                                }
                            }
                            // DEBUG: Print out Roster details
                            println(rosterModel.getRejectedRosterEvents())
                        }
                    }
                }
                // Once data retrieved start segue to Roster View
                self.goToRoster()
            }
        }
        return rosterModel
    }
    
}
