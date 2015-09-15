//
//  RosterEvent.swift
//  VolunteerCheck
//
//  Created by Andrew Brissenden on 30/08/2015.
//  Copyright (c) 2015 Andrew Brissenden. All rights reserved.
//

import Foundation


class RosterEvent: NSObject, Printable {
    var volId: String
    var programName: String
    var date: String
    var startTime: String
    var endTime: String
    var eventJobs: Array<EventJob>
    
    
    override var description: String {
        return "Roster Event: \(volId), \(programName), \(date), \(startTime), \(endTime), \(eventJobs)\n"
    }
    
    init(volId: String?, programName: String?, date: String?, startTime: String?,
        endTime: String?) {
        self.volId = volId ?? ""
        self.programName = programName ?? ""
        self.date = date ?? ""
        self.startTime = startTime ?? ""
        self.endTime = endTime ?? ""
        self.eventJobs = [EventJob]()
    }
    
    // Get Project Name
    func getProgramName() -> String{
        return self.programName
    }
    
    // Get Project Date
    func getEventDate() -> String{
        return self.date
    }
    
    // Get Event start time
    func getStartTime() -> String{
        return startTime
    }
    
    // Get Event end time.
    func getEndTime() -> String{
        return endTime
    }
    
    // Get Array of Event Jobs
    func getEventJobs() -> Array<EventJob>{
        return eventJobs
    }
    
    // Add Event Job to Event Jobs array
    func addEventJob(newJob: EventJob){
        eventJobs.append(newJob)
    }
    
    
    // Remove Event Job from the jobs array
    func removeEventJob(position: Int)
    {
        eventJobs.removeAtIndex(position)
    }
    
}