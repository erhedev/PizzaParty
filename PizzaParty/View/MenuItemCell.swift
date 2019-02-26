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

   
    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    func setMenuItemInfo(menuItem: MenuItem) {
        self.menuItem = menuItem
        self.id = menuItem.id
        categoryLabel.text = menuItem.name
        nameLabel.text = menuItem.name
        priceLabel.text = String(menuItem.price)
    }
    

    @IBAction func orderButtonPresed(_ sender: Any) {
        var order = OrderedItem(menuItem: self.menuItem, quantity: 1)
        MenuList.itemsToOrder.append(order)
        orderButton.isEnabled = false
        orderButton.setTitle("Ordered", for: .disabled)
        orderButton.tintColor = UIColor.darkGray
    }
}
