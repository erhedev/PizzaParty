//
//  Order.swift
//  PizzaParty
//
//  Created by Erik Hede on 2019-02-27.
//  Copyright © 2019 Erik Hede. All rights reserved.
//

import Foundation

class Order{
    var cart : [OrderedItem]!
    var restuarantId : Int!
    
    let restIdDict = ["restuarantId": Int()]
    let cartDict = ["cart": []]
   
    init(cart: [OrderedItem], restuarantId: Int) {
        self.cart = cart
        self.restuarantId = restuarantId
    }
}

//make json object to post to api from data in items to order

//    {
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
//    }

