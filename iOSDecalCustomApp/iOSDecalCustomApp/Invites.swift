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
    let key: String
    
    init(eventID: String, userID: String, present: String, key: String) {
        self.eventId = eventID
        self.username = userID
        self.present = present
        self.key = key
    }
    
}
