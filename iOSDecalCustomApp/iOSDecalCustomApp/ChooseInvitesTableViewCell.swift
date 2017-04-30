//
//  ChooseInvitesTableViewCell.swift
//  iOSDecalCustomApp
//
//  Created by Joshua Zeitsoff on 4/5/17.
//  Copyright © 2017 Cathy Pham Le. All rights reserved.
//

import UIKit

class ChooseInvitesTableViewCell: UITableViewCell {

    @IBOutlet weak var InviteeUsername: UILabel!
    @IBOutlet weak var InviteeName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
