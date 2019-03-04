//
//  OrderStatus.swift
//  PizzaParty
//
//  Created by Erik Hede on 2019-02-26.
//  Copyright © 2019 Erik Hede. All rights reserved.
//

import Foundation

class OrderStatus{

    var orderID : Int
    var totalPrice : Int
    var orderedAt : String
    var estimatedDelivery : String
    var status : String
    var cart : [OrderedItem]?
    
    init(orderID: Int, totalPrice: Int, orderedAt: String, estDel: String, status: String) {
        self.orderID = orderID
        self.totalPrice = totalPrice
        self.orderedAt = orderedAt
        self.estimatedDelivery = estDel
        self.status = status
        self.cart = nil
    }

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
