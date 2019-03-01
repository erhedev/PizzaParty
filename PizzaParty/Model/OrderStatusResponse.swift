//
//  OrderStatusResponse.swift
//  PizzaParty
//
//  Created by Erik Hede on 28/02/2019.
//  Copyright © 2019 Erik Hede. All rights reserved.
//Struct that holds thresponse ffrom when an order is posted

import Foundation
struct OrderStatusResponse: Encodable, Decodable {
    let esitmatedDelivery : String
    let orderId : Int
    let orderedAt : String
    let status : String
    let totalPrice : Int
}
