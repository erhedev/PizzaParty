//
//  PizzeriaCell.swift
//  PizzaParty
//
//  Created by Erik Hede on 2019-02-20.
//  Copyright © 2019 Erik Hede. All rights reserved.
//

//"\(distance ?? 0.00)) km away from you."

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
    var deviceLocation : CLLocation!
    var distance : Double!
   
    
    func setPizzeriaInfo(restaurant: Restaurant, deviceLocation: CLLocation) {
        pizzeria = restaurant
        pizzeriaNameLabel.text = restaurant.name
        pizzeriaAdressLabel.text = restaurant.adress1
//        pizzeriaDistanceLabel.text = "\(restaurant.getDistanceToRestaurant(deviceLocation: location)) km away from you."
        self.deviceLocation = deviceLocation
        distance = pizzeria.getDistanceToRestaurant(deviceLocation: deviceLocation)
        print(distance)
        pizzeriaDistanceLabel.text = String(format: "%.2f km away", distance/1000) 
        restaurantID = restaurant.id
    }
    
    @IBAction func seeMenyTapped(_ sender: Any) {
        delegate?.didTapSeeMenu(id: pizzeria.id)
    }
    
}
