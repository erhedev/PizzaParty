//
//  Restaurant.swift
//  PizzaParty
//
//  Created by Erik Hede on 2019-02-20.
//  Copyright © 2019 Erik Hede. All rights reserved.
//

import Foundation
import SwiftyJSON

class Restaurant {
//response from api
//    "id": 1,
//    "name": "Pizza Heaven",
//    "address1": "Kungsgatan 1",
//    "address2": "111 43 Stockholm",
//    "latitude": 59.336078,
//    "longitude": 18.071807
    var id : Int
    var name : String
    var adress1 : String
    var adress2 : String
    var lat : Double
    var long : Double
    
    init(id: Int, name: String, adress1: String, adress2: String, lat: Double, long: Double) {
        self.id = id
        self.name = name
        self.adress1 = adress1
        self.adress2 = adress2
        self.lat = lat
        self.long = long
    }
    
    func getDistanceToRestaurant() -> Double {
        let lat = self.lat
        let long = self.long
        
        // get user coordinates
        
        //calculate distance to restaurant
        
        
        let distance : Double
        
        // return Calculated distance
        return 1.00
    }
    
    
    
    
}
