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
    
    static func parseRestaurant(json: JSON) -> [Restaurant] {
        
        var restaurants = [Restaurant]()
        
        for result in json.arrayValue{
            let id = result["id"].intValue
            let name = result["name"].stringValue
            let adress1 = result["address1"].stringValue
            let adress2 = result["address2"].stringValue
            let lat = result["latitude"].doubleValue
            let long = result["longitude"].doubleValue
            
            let restaurant = Restaurant(id: id, name: name, adress1: adress1, adress2: adress2, lat: lat, long: long)
            
            restaurants.append(restaurant)
            
//            ListOfRestaurants.listOfRestaurants.append(restaurant)
//
//            print(ListOfRestaurants.listOfRestaurants.count)
//            print("Restaurant added")
            
        }
        
       
        //ParsingDone let notificaton center know
//        NotificationCenter.default.post(name: .doneParsingRestaurants, object: nil)
        
        
        //all menuItems now in array
        // reload menu tableview
        return restaurants

    }
    
    static func parseMenu(json: JSON, restaurantID: Int) -> [MenuItem] {
        //TODO: Change to menu values
        
        var menuItems = [MenuItem]()
        
        for result in json.arrayValue{
            let category = result["category"].stringValue
            let id = result["id"].intValue
            let name = result["name"].stringValue
            let price = result["price"].intValue
            let topping = result["topping"].arrayValue
            let rank = result["rank"].intValue
            
            var toppingArray = [String]()
            
            for item in topping {
                toppingArray.append(item.stringValue)
            }
            
            
            if category == "Pizza" {
                let menuItemPizza = MenuItem(id: id, category: category, name: name, price: price, topping: toppingArray, rank: rank, fromPizzeria: restaurantID)
                menuItems.append(menuItemPizza)
            } else {
                let menuItem = MenuItem(id: id, category: category, name: name, price: price, fromPizzeria: restaurantID)
                menuItems.append(menuItem)
            }
            
            print(MenuList.pizzaList.count + MenuList.sidesList.count)
            print("MenuItem added")
            
        }
        
        return menuItems
        
        //ParsingDone let notificaton center know
//        NotificationCenter.default.post(name: .doneParsingMenu, object: nil)
        
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
            
            MenuList.orderStatuses.removeAll()
            MenuList.orderStatuses.append(order)
        }
       
        //Parsing Done let notificaton center know
        NotificationCenter.default.post(name: .doneParsingOrderStatus, object: nil)
        
    }
    
    
}
