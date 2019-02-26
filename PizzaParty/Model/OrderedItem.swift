//
//  OrderedItem.swift
//  PizzaParty
//
//  Created by Erik Hede on 2019-02-26.
//  Copyright © 2019 Erik Hede. All rights reserved.
//

import Foundation

class OrderedItem {
    
    var  menuItemId : Int!
    var quantity : Int!
    
    init(menuItem: MenuItem, quantity: Int) {
        self.menuItemId = menuItem.id
        self.quantity = quantity
    }
    
    init(menuItem: String, quantity: Int) {
        self.menuItemId = Int(menuItem)
        self.quantity = quantity
    }
}
