//
//  Order.swift
//  PizzaParty
//
//  Created by Erik Hede on 2019-02-27.
//  Copyright © 2019 Erik Hede. All rights reserved.
//

import Foundation

class Order {
    var cart : [OrderedItem]!
    var restuarantId : Int!
    
    init(cart: [OrderedItem], restuarantId: Int) {
        self.cart = cart
        self.restuarantId = restuarantId
    }
}


