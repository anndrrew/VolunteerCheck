//
//  EventCell.swift
//  VolunteerCheck
//
//  Created by Andrew Brissenden on 31/08/2015.
//  Copyright (c) 2015 Andrew Brissenden. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {

    // MARK: Properties
    @IBOutlet weak var jobNameLabel: UILabel!
    @IBOutlet weak var areaDescriptionLabel: UILabel!
    @IBOutlet weak var acceptBtn: ListButton!
    @IBOutlet weak var rejectBtn: ListButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
