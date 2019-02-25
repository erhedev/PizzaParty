//
//  Items.swift
//  PizzaParty
//
//  Created by Erik Hede on 2019-02-20.
//  Copyright © 2019 Erik Hede. All rights reserved.
//

import Foundation

// https://private-anon-a2a1a5ab76-pizzaapp.apiary-mock.com/restaurants/1/menu
//[
//    {
//        "id": 1,
//        "category": "Pizza",
//        "name": "Vesuvius",
//        "topping": [
//        "Tomat",
//        "Ost",
//        "Skinka"
//        ],
//        "price": 79,
//        "rank": 3
//    },
//    {
//        "id": 2,
//        "category": "Pizza",
//        "name": "Hawaii",
//        "topping": [
//        "Tomat",
//        "Ost",
//        "Skinka",
//        "Ananas"
//        ],
//        "price": 79,
//        "rank": 1
//    },
//    {
//        "id": 3,
//        "category": "Pizza",
//        "name": "Parma",
//        "topping": [
//        "Tomat",
//        "Ost",
//        "Parmaskinka",
//        "Oliver",
//        "Färska basilika"
//        ],
//        "price": 89,
//        "rank": 2
//    },
//    {
//        "id": 4,
//        "category": "Dryck",
//        "name": "Coca-cola, 33cl",
//        "price": 10
//    },
//    {
//        "id": 5,
//        "category": "Dryck",
//        "name": "Loka citron, 33cl",
//        "price": 10
//    },
//    {
//        "id": 6,
//        "category": "Tillbehör",
//        "name": "Pizzasallad",
//        "price": 0
//    },
//    {
//        "id": 7,
//        "category": "Tillbehör",
//        "name": "Bröd och smör",
//        "price": 10
//    }
//]

class MenuItem {
    
    var id : Int!
    var category : String!
    var name : String!
    var price : Int!
    var topping : [Any]!
    var rank : Int!
    
    init(id: Int, category: String, name: String, price: Int) {
        self.id = id
        self.category = category
        self.name = name
        self.price = price
    }
    
    init(id: Int, category: String, name: String, price: Int, topping: [Any], rank: Int) {
        self.id = id
        self.category = category
        self.name = name
        self.price = price
        self.topping = topping
        self.rank = rank
    }
    
    
    
}


