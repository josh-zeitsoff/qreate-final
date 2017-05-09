//
//  Invites.swift
//  iOSDecalCustomApp
//
//  Created by Cathy Pham Le on 4/29/17.
//  Copyright © 2017 Cathy Pham Le. All rights reserved.
//

import Foundation

class Invites {
    
    let eventId: String
    let username: String
    var present: String
    init(eventID: String, userID: String, present: String) {
        self.eventId = eventID
        self.username = userID
        self.present = present
    }
    
}
