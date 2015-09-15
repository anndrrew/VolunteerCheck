//
//  Volunteer.swift
//  VolunteerCheck
//
//  Created by Andrew Brissenden on 30/08/2015.
//  Copyright (c) 2015 Andrew Brissenden. All rights reserved.
//

import Foundation

class Volunteer: NSObject{
    // MARK: Properties
    
    var id: String
    var email: String
    
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory: AnyObject = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("testVolunteer")
    
    
    // MARK: Types
    
    struct PropertyKey {
        static let idKey = "id"
        static let emailKey = "email"
    }
    
    
    // MARK: Initialization
    
    init(id: String, email: String) {
        self.id = id
        self.email = email
        
         super.init()
        
//        if id.isEmpty || email.isEmpty {
//            return nil
//        }
    }
    
    
    required convenience init(coder aDecoder: NSCoder) {
        
        let id = aDecoder.decodeObjectForKey(PropertyKey.idKey) as! String
        let email = aDecoder.decodeObjectForKey(PropertyKey.emailKey) as! String
        
        self.init(id: id, email: email)
        
    }
    
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(id, forKey: PropertyKey.idKey)
        aCoder.encodeObject(email, forKey: PropertyKey.emailKey)
    }
    
    
    // Get Volunteer Details
    func getId() ->String{
        return id;
    }
    func getEmail() ->String{
        return email;
    }
    
    // Set Volunteer details
    func setVolId(volId: String){
        self.id = volId
    }
    func setVolEmail(volEmail: String){
        self.email = volEmail
    }
}