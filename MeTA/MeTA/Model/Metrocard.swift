//
//  Metrocard.swift
//  MeTA
//
//  Created by salman siraj on 3/3/20.
//  Copyright © 2020 senior design. All rights reserved.
//

import Foundation
import RealmSwift

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

