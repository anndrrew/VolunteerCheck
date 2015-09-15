//
//  DataManager.swift
//  VolunteerCheck
//
//  Created by Andrew Brissenden on 19/08/2015.
//  Copyright (c) 2015 Andrew Brissenden. All rights reserved.
//

import Foundation


let VOLUNTEER_DETAILS = "http://willconsider.org/swiftdata/roster_test.json"
let HTTP_WRONG_CODE_STRING = "HTTP status code has unexpected value."
let REQUEST_DOMAIN = "org.willconsider"

class DataManager: NSObject{
    
//    // Get Volunteer Roster From Server
//    class func getVolunteerData(rosterModel: RosterModel) ->RosterModel{
//        
//        DataManager.getRosterWithSuccess { (volunteersData) -> Void in
//            let json = JSON(data: volunteersData)
//            
//            // Get Array of values from JSON Object
//            if let rosterArray = json["vol_roster"].array{
//                
//                //
//                for rosterDict in rosterArray{
//                    var volId: String? = rosterDict["volId"].string
//                    var programName: String? = rosterDict["programName"].string
//                    var date: String? = rosterDict["date"].string
//                    var startTime: String? = rosterDict["startTime"].string
//                    var endTime: String? = rosterDict["endTime"].string
//                    
//                    // Create temp Roster Event Object
//                    var event = RosterEvent(volId: volId, programName: programName, date: date, startTime: startTime, endTime: endTime)
//                    
//                    // Add New Roster event to events array
//                    rosterModel.addRosterEvent(event)
//                    
//                    // Add Jobs to Jobs array ascociated with the event
//                    if let jobArray = rosterDict["areaNames"].array{
//                        
//                        for jobDict in jobArray{
//                            var areaName: String? = jobDict["areaName"].string
//                            var confirmBy: String? = jobDict["confirmBy"].string
//                            var reminder: String? = jobDict["reminder"].string
//                            var information: String? = jobDict["description"].string
//                            
//                            // Create temp Event job object
//                            var job = EventJob(areaName: areaName,  confirmBy: confirmBy, reminder: reminder, information: information)
//                            
//                            // Add new Job to Jobs Array
//                            rosterModel.getRosterEvent(programName!, eventDate: date!).addEventJob(job)
//                        }
//                    }
//                    // DEBUG: Print out Roster details
//                    println(rosterModel.getRosterEvents())
//                }
//                // Once data retrieved start segue to Roster View
//                //                self.goToRoster()
//            }
//        }
//        return rosterModel
//    }
    
    
    //
    class func getRosterWithSuccess(success: ((volunteersData: NSData!) -> Void)) {
        //
        loadDataFromURL(NSURL(string: VOLUNTEER_DETAILS)!, completion:{(data, error) -> Void in
            //
            if let urlData = data {
                //
                success(volunteersData: urlData)
            }
        })
    }
    
    // Generic func to load JSON data form URL using swiftlyJSON Lib.
    class func loadDataFromURL(url: NSURL, completion:(data: NSData?, error: NSError?) -> Void) {
        var session = NSURLSession.sharedSession()
        
        // Use NSURLSession to get data from an NSURL
        let loadDataTask = session.dataTaskWithURL(url, completionHandler: { (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
            if let responseError = error {
                completion(data: nil, error: responseError)
            } else if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    var statusError = NSError(domain:REQUEST_DOMAIN, code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : HTTP_WRONG_CODE_STRING])
                    completion(data: nil, error: statusError)
                } else {
                    completion(data: data, error: nil)
                }
            }
        })
        
        loadDataTask.resume()
    }
}