//
//  EventHeaderCell.swift
//  VolunteerCheck
//
//  Created by Andrew Brissenden on 4/09/2015.
//  Copyright (c) 2015 Andrew Brissenden. All rights reserved.
//

import UIKit

class EventHeaderCell: UITableViewCell {

    @IBOutlet weak var programNameLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var eventStartLabel: UILabel!
    @IBOutlet weak var eventEndLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
