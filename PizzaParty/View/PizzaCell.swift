//
//  PizzaCell.swift
//  PizzaParty
//
//  Created by Erik Hede on 2019-02-25.
//  Copyright © 2019 Erik Hede. All rights reserved.
//

import UIKit

protocol PizzaCellDelegate {
    func didTapAddToCart(itemID: Int, restaurantID: Int)
}

class PizzaCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var toppingLabel: UILabel!
    
    var pizza: MenuItem!
    var pizzaID: Int!
    var delegate: PizzaCellDelegate?
    
    func setPizzaInfo(menuItem: MenuItem) {
        pizza = menuItem
        nameLabel.text = pizza.name
        priceLabel.text = "\(String(describing: pizza.price)) kr"
        toppingLabel.text = "\(String(describing: pizza.topping))"
        pizzaID = menuItem.id
    }
   
    @IBAction func orderButton(_ sender: Any) {
        delegate?.didTapAddToCart(itemID: pizzaID, restaurantID: ListOfRestaurants.listOfRestaurants[ListOfRestaurants.listOfRestaurants.count-1].id )
    }
}
