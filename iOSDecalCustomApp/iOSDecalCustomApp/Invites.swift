//
//  Invites.swift
//  iOSDecalCustomApp
//
//  Created by Cathy Pham Le on 4/29/17.
//  Copyright © 2017 Cathy Pham Le. All rights reserved.
//

import Foundation

class Invites {
    
    let eventID: String
    let userID: String
    let count: Int
    
    init(eventID: String, userID: String, count: Int) {
        self.eventID = eventID
        self.userID = userID
        self.count = count
    }
    
}
