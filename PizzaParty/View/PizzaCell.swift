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
    
    var counter = 0
   
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
        let menuItem = MenuItem(id: self.pizza.id, category: self.pizza.category, name: self.pizza.name, price: self.pizza.price, topping: self.pizza.topping, rank: self.pizza.rank, fromPizzeria: self.pizza.fromPizzeria)
        MenuList.itemsToOrder.append(order)
        MenuList.menuItemsToOrder.append(menuItem)
        print(MenuList.itemsToOrder.count)
        print(MenuList.itemsToOrder[MenuList.itemsToOrder.count-1].menuItemId)
        orderButton.tintColor = UIColor.darkGray
        orderButton.isEnabled = false
        orderButton.setTitle("Ordered", for: .disabled)
       
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.counter += 1
            self.orderButton.isEnabled = true
            self.orderButton.setTitle("\(self.counter) Ordered", for: .normal)
        }
    }
}
