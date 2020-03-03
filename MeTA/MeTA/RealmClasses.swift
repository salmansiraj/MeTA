//
//  RealmClasses.swift
//  MeTA
//
//  Created by Hansen  on 3/2/20.
//  Copyright © 2020 senior design. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    @objc dynamic var firstName = ""
    @objc dynamic var lastName = ""
    @objc dynamic var username = ""
    @objc dynamic var password = ""
    
    override static func primaryKey() -> String? {
        return "username"
    }
}

class Metrocard: Object{
    @objc dynamic var username: User?
    @objc dynamic var cardID = 0
    @objc dynamic var balance = 0
    @objc dynamic var expirationDate = Date()
    @objc dynamic var cardType = ""
    @objc dynamic var reloadTime = Date()
    
    override static func primaryKey() -> String? {
        return "cardID"
    }
}


