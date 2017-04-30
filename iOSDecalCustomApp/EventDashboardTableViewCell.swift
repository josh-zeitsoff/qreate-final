//
//  EventDashboardTableViewCell.swift
//  iOSDecalCustomApp
//
//  Created by Joshua Zeitsoff on 4/5/17.
//  Copyright © 2017 Cathy Pham Le. All rights reserved.
//

import UIKit

class EventDashboardTableViewCell: UITableViewCell {

    @IBOutlet weak var EventImage: UIImageView!
    
    @IBOutlet weak var EventDate: UILabel!
    @IBOutlet weak var EventName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
