//
//  MenuItemCell.swift
//  PizzaParty
//
//  Created by Erik Hede on 2019-02-25.
//  Copyright © 2019 Erik Hede. All rights reserved.
//

import UIKit

class MenuItemCell: UITableViewCell {
    
    var menuItem: MenuItem!
    var id : Int!
    var category : String!
    var name : String!
    var price : Int!
    
    var counter = 0

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    func setMenuItemInfo(menuItem: MenuItem) {
        self.menuItem = menuItem
        self.id = menuItem.id
        self.categoryLabel.text = menuItem.category
        self.nameLabel.text = menuItem.name
        self.priceLabel.text = String(menuItem.price)
    }
    

    @IBAction func orderButtonPresed(_ sender: Any) {
        let order = OrderedItem(menuItem: self.menuItem, quantity: 1)
        let menuItem = MenuItem(id: self.menuItem.id, category: self.menuItem.category, name: self.menuItem.name, price: self.menuItem.price, fromPizzeria: self.menuItem.fromPizzeria)
        MenuList.itemsToOrder.append(order)
        MenuList.menuItemsToOrder.append(menuItem)
        orderButton.isEnabled = false
        orderButton.setTitle("Ordered", for: .disabled)
        orderButton.tintColor = UIColor.darkGray
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.counter += 1
            self.orderButton.isEnabled = true
            self.orderButton.setTitle("\(self.counter) Ordered", for: .normal)
        }
    }
}
