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
    let userId: String
    var count: Int
    
    init(eventID: String, userID: String, count: Int) {
        self.eventId = eventID
        self.userId = userID
        self.count = count
    }
    
}
