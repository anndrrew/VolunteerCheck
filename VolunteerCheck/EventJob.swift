//
//  EventJob.swift
//  VolunteerCheck
//
//  Created by Andrew Brissenden on 2/09/2015.
//  Copyright (c) 2015 Andrew Brissenden. All rights reserved.
//

import Foundation


class EventJob: NSObject, Printable {
    var areaName: String
    var confirmBy: String
    var reminder: String
    var information: String
    
    
    override var description: String {
        return "Event Job: \(areaName), \(confirmBy), \(reminder), \(information)\n"
    }
    
    init(areaName: String?, confirmBy: String?, reminder: String?, information: String?) {
            self.areaName = areaName ?? ""
            self.confirmBy = confirmBy ?? ""
            self.reminder = reminder ?? ""
            self.information = information ?? ""
    }
    
    // Get Project Job Area name.
    func getAreaName() -> String{
        return areaName
    }
    
    // Get Date and time the event needs to be confirmed by
    func getConfirmBy() -> String{
        return confirmBy
    }
    
    // Get the time before the confirm by date and time the event should rmeind the user
    func getReminder() -> String{
        return reminder
    }
    
    // Get the description of the jobs event
    func getInformation() ->String{
        return information
    }
}