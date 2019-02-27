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
    
//    static var restaurantVC = ClosestPizzeriaVC()
    
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
    
    static func parseMenu(json: JSON, restaurantID: Int) {
        //TODO: Change to menu values
        for result in json.arrayValue{
            let category = result["category"].stringValue
            let id = result["id"].intValue
            let name = result["name"].stringValue
            let price = result["price"].intValue
            let topping = result["topping"].arrayValue
            let rank = result["rank"].intValue
            
            if category == "Pizza" {
                let menuItemPizza = MenuItem(id: id, category: category, name: name, price: price, topping: topping, rank: rank, fromPizzeria: restaurantID)
            MenuList.pizzaList.append(menuItemPizza)
            } else {
                let menuItem = MenuItem(id: id, category: category, name: name, price: price, fromPizzeria: restaurantID)
                MenuList.sidesList.append(menuItem)
            }
            
            print(MenuList.pizzaList.count + MenuList.sidesList.count)
            print("MenuItem added")
            
        }
        
        //ParsingDone let notificaton center know
        NotificationCenter.default.post(name: .doneParsingMenu, object: nil)
        
        //all menuItems now in array
        // reload menu tableview
        
    }
    
    static func parseOrderStatus(json: JSON) {
        for result in json.arrayValue {
            let orderID = result["orderId"].intValue
            let totalPrice = result["totalPrice"].intValue
            let orderedAt = result["orderedAt"].stringValue
            let estimatedDelivery = result["esitmatedDelivery"].stringValue
            let status = result["status"].stringValue
            let cart = result["cart"].arrayValue
            
            var cartObj = [String]()
            
            for item in cart {
                cartObj.append(item.stringValue)
            }
            
            let order = OrderStatus(orderID: orderID, totalPrice: totalPrice, orderedAt: orderedAt, estDel: estimatedDelivery, status: status, cart: cartObj)
            
            StatusVC.orderStatus = order
        }
       
        //Parsing Done let notificaton center know
        NotificationCenter.default.post(name: .doneParsingOrderStatus, object: nil)
        
    }
    
    
}
