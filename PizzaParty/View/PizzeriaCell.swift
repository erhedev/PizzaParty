//
//  PizzeriaCell.swift
//  PizzaParty
//
//  Created by Erik Hede on 2019-02-20.
//  Copyright © 2019 Erik Hede. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

protocol PizzeriaCellDelegate {
    func didTapSeeMenu(id: Int)
}

class PizzeriaCell: UITableViewCell {
    // class for tableview cell
    
    @IBOutlet weak var pizzeriaNameLabel: UILabel!
    @IBOutlet weak var pizzeriaAdressLabel: UILabel!
    @IBOutlet weak var pizzeriaDistanceLabel: UILabel!
    
    var pizzeria: Restaurant!
    var restaurantID : Int!
    var delegate: PizzeriaCellDelegate?
    
    func setPizzeriaInfo(restaurant: Restaurant, location: Double) {
        pizzeria = restaurant
        pizzeriaNameLabel.text = restaurant.name
        pizzeriaAdressLabel.text = restaurant.adress1
//        pizzeriaDistanceLabel.text = "\(restaurant.getDistanceToRestaurant(deviceLocation: location)) km away from you."
        pizzeriaDistanceLabel.text = "\(location)) km away from you."
        restaurantID = restaurant.id
    }
    
    @IBAction func seeMenyTapped(_ sender: Any) {
        delegate?.didTapSeeMenu(id: pizzeria.id)
    }
    
}
