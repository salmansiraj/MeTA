//
//  GooglePlace.swift
//  MeTA
//
//  Created by Kevin J. Zheng on 2/29/20.
//  Copyright © 2020 senior design. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation
import SwiftyJSON

class GooglePlace {
    let name: String
    let address: String
    let coordinate: CLLocationCoordinate2D
    let placeType: String
    var photoReference: String?
    var photo: UIImage?
    
    init(dictionary: [String: Any], acceptedTypes: [String]) {
        let json = JSON(dictionary)
        name = json["name"].stringValue
        address = json["vicinity"].stringValue

        let lat = json["geometry"]["location"]["lat"].doubleValue as CLLocationDegrees
        let lng = json["geometry"]["location"]["lng"].doubleValue as CLLocationDegrees
        coordinate = CLLocationCoordinate2DMake(lat, lng)

        photoReference = json["photos"][0]["photo_reference"].string

        var foundType = "establishment"
        let possibleTypes = acceptedTypes.count > 0 ? acceptedTypes : ["subway_station","train_station", "transit_station", "point_of_interest", "establishment"]

        if let types = json["types"].arrayObject as? [String] {
          for type in types {
            if possibleTypes.contains(type) {
              foundType = type
              break
            }
          }
        }
      placeType = foundType
    }
}

