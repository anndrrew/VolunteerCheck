//
//  ViewController.swift
//  VolunteerCheck
//
//  Created by Andrew Brissenden on 19/08/2015.
//  Copyright (c) 2015 Andrew Brissenden. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate{
    // MARK: Properties
    @IBOutlet weak var enterLogInLabel: UILabel!
    @IBOutlet weak var volIDTextField: UITextField!
    @IBOutlet weak var volEmailTextField: UITextField!
    @IBOutlet weak var logInMessage: UILabel!
    @IBOutlet weak var logInButton: UIButton!
    
    // MARK: Properties
    var rosterModel: RosterModel!
    var testVolunteer = Volunteer?()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field’s user input through delegate callbacks.
        volIDTextField.delegate = self
        volEmailTextField.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(textField: UITextField) {

    }
    
    
    // Check If User Credentials are Valid and populate modal
    func userValidates() -> Bool{
        // CHECK LOG IN AGAINST LOCAL TEST DATA
        return true
        
    }
    
    
    // MARK: Navigation
    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if logInButton === sender{
            

            let volEmail = volEmailTextField.text
            let volId = volIDTextField.text

            
            // Set the meal to be passed to MealListTableViewController after the unwind segue.
            testVolunteer = Volunteer(id: volId, email: volEmail)
        }
    }
}

