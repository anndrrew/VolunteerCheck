//
//  RosterModel.swift
//  VolunteerCheck
//
//  Created by Andrew Brissenden on 21/08/2015.
//  Copyright (c) 2015 Andrew Brissenden. All rights reserved.
//

import Foundation

class RosterModel: NSObject, Printable {
    
    // MARK: - Properties
    var volunteer: Volunteer
    var rosterEvents: Array<RosterEvent>
    var acceptedRosterEvents: Array<RosterEvent>
    var rejectedRosterEvents: Array<RosterEvent>
    
    // DEBUG: Test Strings
    let ID_TEST = "1"
    let EMAIL_TEST = "a"

    
    override init()
    {
        // Initialise Volunteer object
        volunteer = Volunteer(id: ID_TEST, email: EMAIL_TEST)
        
        // Initalise Empty Array for Roster Events
        rosterEvents = [RosterEvent]()
        acceptedRosterEvents = [RosterEvent]()
        rejectedRosterEvents = [RosterEvent]()
        
    }
    
    
    // Get Volunteers Details
    func getVolunteer() -> Volunteer
    {
        return volunteer
    }
    
    
    // Get Array of Roster Events
    func getRosterEvents() -> Array<RosterEvent>
    {
        return rosterEvents
    }
    
    
    // Get Array of Accepted Roster Events
    func getAcceptedRosterEvents() -> Array<RosterEvent>
    {
        return acceptedRosterEvents
    }
    
    
    // Get Array of Rejected Roster Events
    func getRejectedRosterEvents() -> Array<RosterEvent>
    {
        return rejectedRosterEvents
    }
    
    
    // Get Individual Roster Event by Program name and Date
    func getRosterEvent(programName: String, eventDate: String) ->RosterEvent
    {
            for event in rosterEvents{
                if (programName == event.getProgramName() &&
                    eventDate == event.getEventDate()){
                        return event
                }
            }
        return rosterEvents[0]
    }
    
    
    // Get Individual Roster Event by Program name and Date
    func getAcceptedRosterEvent(programName: String, eventDate: String) ->RosterEvent
    {
        for event in acceptedRosterEvents{
            if (programName == event.getProgramName() &&
                eventDate == event.getEventDate()){
                    return event
            }
        }
        return acceptedRosterEvents[0]
    }
    
    
    // Get Individual Roster Event by Program name and Date
    func getRejectedRosterEvent(programName: String, eventDate: String) ->RosterEvent
    {
        for event in rejectedRosterEvents{
            if (programName == event.getProgramName() &&
                eventDate == event.getEventDate()){
                    return event
            }
        }
        return rejectedRosterEvents[0]
    }
    
    
    // Add Roster Event to Roster Events array
    func addRosterEvent(newEvent: RosterEvent)
    {
        rosterEvents.append(newEvent)
    }
    
    
    // Remove Rostered event job and check if roster event needs deletion.
    func removeRosterEventJob(currEvent: RosterEvent, currJob: EventJob) -> Bool
    {
        // Find the roster event containing the job.
        var j = 0
        for event in rosterEvents
        {
            if (currEvent.programName == event.getProgramName() &&
                currEvent.date == event.getEventDate())
            {
                // Find Job in event and its position in the array
                var i = 0
                for job in event.getEventJobs()
                {
                    if (job.areaName == currJob.areaName)
                    {
                        event.removeEventJob(i)
                    }
                    i++
                }
                
                // Check if event has any more jobs
                if (event.getEventJobs().count == 0)
                {
                    // Delete event aswell
                    removeEvent(j)
                    return true
                }
                
                return true
            }
            j++
        }
        return false
    }
    
    
    // Delete Roster Event
    func removeEvent(position: Int)
    {
        rosterEvents.removeAtIndex(position)
    }
    
    
    // Remove Rostered event job and check if roster event needs deletion.
    func removeAcceptedRosterEventJob(currEvent: RosterEvent, currJob: EventJob) -> Bool
    {
        // Find the roster event containing the job.
        var j = 0
        for event in acceptedRosterEvents
        {
            if (currEvent.programName == event.getProgramName() &&
                currEvent.date == event.getEventDate())
            {
                // Find Job in event and its position in the array
                var i = 0
                for job in event.getEventJobs()
                {
                    if (job.areaName == currJob.areaName)
                    {
                        event.removeEventJob(i)
                    }
                    i++
                }
                
                // Check if event has any more jobs
                if (event.getEventJobs().count == 0)
                {
                    // Delete event aswell
                    removeAcceptedEvent(j)
                    return true
                }
                
                return true
            }
            j++
        }
        return false
    }
    
    
    // Delete Accepted Roster Event
    func removeAcceptedEvent(position: Int)
    {
        acceptedRosterEvents.removeAtIndex(position)
    }
    
    
    // Add Roster Event to Roster Events array
    func addAcceptedRosterEvent(newEvent: RosterEvent)
    {
        acceptedRosterEvents.append(newEvent)
    }
    
    
    // Add Roster Event Job to the Accepted Roster Event Array
    func addAcceptedRosterEventJob(newEvent: RosterEvent, newJob: EventJob) ->Bool
    {

        // Check if event exists for user in Accepted List
        for event in acceptedRosterEvents
        {
            if (newEvent.programName == event.getProgramName() &&
                newEvent.date == event.getEventDate()){
                    
                    // Add new event job to event job array
                    event.addEventJob(newJob)
                    
                    println("++++++++++++++++++++++++++++++++++++++++++++++++++++")
                    println(acceptedRosterEvents)
                    println("++++++++++++++++++++++++++++++++++++++++++++++++++++")
                    
                    return true
            }
            
        }
        
        // If Roster Event is not currently apart of the accepted roster event list add it.
        var tempEvent = RosterEvent(volId: newEvent.volId, programName: newEvent.programName, date: newEvent.date, startTime: newEvent.startTime, endTime: newEvent.endTime)
        
        tempEvent.addEventJob(newJob)
        
        self.addAcceptedRosterEvent(tempEvent)
        
        println("++++++++++++++++++++++++++++++++++++++++++++++++++++")
        println(acceptedRosterEvents)
        println("++++++++++++++++++++++++++++++++++++++++++++++++++++")
        
        return true
    }
    
    
    // Add Roster Event to Roster Events array
    func addRejectedRosterEvent(newEvent: RosterEvent)
    {
        rejectedRosterEvents.append(newEvent)
    }
    

    // Add Roster Event Job to the Rejected Roster Event Array
    func addRejectedRosterEventJob(newEvent: RosterEvent, newJob: EventJob) ->Bool
    {
        
        // Check if event exists for user in rejected List
        for event in rejectedRosterEvents
        {
            if (newEvent.programName == event.getProgramName() &&
                newEvent.date == event.getEventDate()){
                    
                    // Add new event job to event job array
                    event.addEventJob(newJob)
                    
                    println("++++++++++++++++++++++++++++++++++++++++++++++++++++")
                    println(rejectedRosterEvents)
                    println("++++++++++++++++++++++++++++++++++++++++++++++++++++")
                    
                    return true
            }
            
        }
        
        // If Roster Event is not currently apart of the accepted roster event list add it.
        var tempEvent = RosterEvent(volId: newEvent.volId, programName: newEvent.programName, date: newEvent.date, startTime: newEvent.startTime, endTime: newEvent.endTime)
        
        tempEvent.addEventJob(newJob)
        
        self.addRejectedRosterEvent(tempEvent)
        
        println("++++++++++++++++++++++++++++++++++++++++++++++++++++")
        println(rejectedRosterEvents)
        println("++++++++++++++++++++++++++++++++++++++++++++++++++++")
        
        return true
    }
}