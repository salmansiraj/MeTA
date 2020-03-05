//
//  User.swift
//  MeTA
//
//  Created by salman siraj on 3/3/20.
//  Copyright © 2020 senior design. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    @objc dynamic var firstName = ""
    @objc dynamic var lastName = ""
    @objc dynamic var username = ""
    @objc dynamic var email = ""
    @objc dynamic var password = ""
    
    override static func primaryKey() -> String? {
        return "username"
    }
}
