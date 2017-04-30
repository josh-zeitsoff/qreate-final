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
    let date: Date
    
    /// Name of the event host
    let host: String

    /// List of strings of names of people who were invited
    let invitedPeople: [String]


    /// Location of event
    let location: String
    
    
    /// Name of the event  
    let name: String

    
    /// The ID of the event, generated automatically on Firebase
    let eventId: String

    init(dateString: String, host: String, invitedPeople: [String], location: String, name: String, id: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        self.date = dateFormatter.date(from: dateString)!
        self.host = host
        self.invitedPeople = invitedPeople
        self.location = location
        self.name = name
        self.eventId = id
    }





}
