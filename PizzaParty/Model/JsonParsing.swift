//
//  JsonParsing.swift
//  PizzaParty
//
//  Created by Erik Hede on 2019-02-20.
//  Copyright © 2019 Erik Hede. All rights reserved.
//

import Foundation
import SwiftyJSON

class JSONParsing {
    
    static var restaurantVC = ClosestPizzeriaVC()
    
    static func parseRestaurant(json: JSON) {
        for result in json.arrayValue{
            let id = result["id"].intValue
            let name = result["name"].stringValue
            let adress1 = result["address1"].stringValue
            let adress2 = result["address2"].stringValue
            let lat = result["latitude"].doubleValue
            let long = result["longitude"].doubleValue
            
            let restaurant = Restaurant(id: id, name: name, adress1: adress1, adress2: adress2, lat: lat, long: long)
            
            ListOfRestaurants.listOfRestaurants.append(restaurant)
            
            print(ListOfRestaurants.listOfRestaurants.count)
            print("Restaurant added")
            
        }
        //ParsingDone let notificaton center know
        NotificationCenter.default.post(name: .doneParsingRestaurants, object: nil)
        
        //all menuItems now in array
        // reload menu tableview
        
    }
    
    static func parseMenu(json: JSON) {
        
        //TODO: Change to menu values
        for result in json.arrayValue{
            let category = result["category"].stringValue
            let id = result["id"].intValue
            let name = result["name"].stringValue
            let price = result["price"].intValue
            let topping = result["topping"].arrayValue
            let rank = result["rank"].intValue
            
            if category == "Pizza" {
            let menuItemPizza = MenuItem(id: id, category: category, name: name, price: price, topping: topping, rank: rank)
            MenuList.itemsInMenu.append(menuItemPizza)
            } else {
                let menuItem = MenuItem(id: id, category: category, name: name, price: price)
                MenuList.itemsInMenu.append(menuItem)
            }
            
            print(MenuList.itemsInMenu.count)
            print("MenuItem added")
            
        }
        
        //ParsingDone let notificaton center know
        NotificationCenter.default.post(name: .doneParsingMenu, object: nil)
        
        //all menuItems now in array
        // reload menu tableview
        
    }
    
    
}
