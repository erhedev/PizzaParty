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
    @IBOutlet weak var orderButton: UIButton!
   
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
        let order = OrderedItem(menuItem: self.pizza, quantity: 1)
        MenuList.itemsToOrder.append(order)
        print(MenuList.itemsToOrder.count)
        print(MenuList.itemsToOrder[MenuList.itemsToOrder.count-1].menuItemId)
        orderButton.tintColor = UIColor.darkGray
        orderButton.isEnabled = false
        orderButton.setTitle("Ordered", for: .disabled)
    }
}
