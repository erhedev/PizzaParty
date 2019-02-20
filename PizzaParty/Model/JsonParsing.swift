//
//  JsonParsing.swift
//  PizzaParty
//
//  Created by Erik Hede on 2019-02-20.
//  Copyright © 2019 Erik Hede. All rights reserved.
//

import Foundation

import Foundation
import SwiftyJSON

class JSONParsing {
    static func parseRestaurant(json: JSON) {
        for result in json["restaurants"].arrayValue{
            let id = result["id"].intValue
            let name = result["name"].stringValue
            let adress1 = result["adress1"].stringValue
            let adress2 = result["adress2"].stringValue
            let lat = result["latitude"].doubleValue
            let long = result["longitude"].doubleValue
            
            let restaurant = Restaurant(id: id, name: name, adress1: adress1, adress2: adress2, lat: lat, long: long)
            
            ListOfRestaurants.listOfRestaurants.append(restaurant)
            
        }
    }
    
    
}
