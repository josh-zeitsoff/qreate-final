//
//  Event.swift
//  iOSDecalCustomApp
//
//  Created by Joshua Zeitsoff on 4/24/17.
//  Copyright © 2017 Cathy Pham Le. All rights reserved.
//

import Foundation

class Event {
    
    
    /// The date of the event
    let date: String
    
    /// Name of the event host
    let host: String

    /// Location of event
    let location: String
    
    
    /// Name of the event  
    let name: String

    
    /// The ID of the event, generated automatically on Firebase
    let eventId: String

    init(dateString: String, host: String, location: String, name: String, id: String) {
        self.date = dateString
        self.host = host
        self.location = location
        self.name = name
        self.eventId = id
    }





}
