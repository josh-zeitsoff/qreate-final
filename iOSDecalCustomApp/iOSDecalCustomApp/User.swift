//
//  User.swift
//  iOSDecalCustomApp
//
//  Created by Ali Mousa on 5/1/17.
//  Copyright © 2017 Cathy Pham Le. All rights reserved.
//

import Foundation

class User {
    var qr: String?
    var hosting: [String]
    var username: String?
    
    init(q :String?, host : [String], name: String?) {
        qr = q!
        hosting = host
        username = name!
    }
}
