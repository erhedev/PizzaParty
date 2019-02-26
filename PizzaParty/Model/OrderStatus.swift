//
//  OrderStatus.swift
//  PizzaParty
//
//  Created by Erik Hede on 2019-02-26.
//  Copyright © 2019 Erik Hede. All rights reserved.
//

import Foundation
//response
//{
//    "orderId": 1234412,
//    "totalPrice": 168,
//    "orderedAt": "2015-04-09T17:30:47.556Z",
//    "esitmatedDelivery": "2015-04-09T17:50:47.556Z",
//    "status": "baking",
//    "cart": [
//    {
//    "menuItemId": 2,
//    "quantity": 1
//    },
//    {
//    "menuItemId": 3,
//    "quantity": 1
//    },
//    {
//    "menuItemId": 6,
//    "quantity": 2
//    }
//    ],
//    "restuarantId": 1
//}
class OrderStatus {
    
    var orderID : Int
    var totalPrice : Int
    var orderedAt : String
    var estimatedDelivery : String
    var status : String
    var cart : [OrderedItem]
    
    init(orderID: Int, totalPrice: Int, orderedAt: String, estDel: String, status: String, cart: [OrderedItem]) {
        self.orderID = orderID
        self.totalPrice = totalPrice
        self.orderedAt = orderedAt
        self.estimatedDelivery = estDel
        self.status = status
        self.cart = cart
    }
    
    init(orderID: Int, totalPrice: Int, orderedAt: String, estDel: String, status: String, cart: [String]) {
        self.orderID = orderID
        self.totalPrice = totalPrice
        self.orderedAt = orderedAt
        self.estimatedDelivery = estDel
        self.status = status
        
        var orderedItem : OrderedItem
        var itemList = [OrderedItem]()
        
        for item in cart {
            orderedItem = OrderedItem(menuItem: item, quantity: 1)
            itemList.append(orderedItem)
        }
    
        self.cart = itemList
    }
    

    
}
