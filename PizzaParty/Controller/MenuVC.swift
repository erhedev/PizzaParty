//
//  MenuVC.swift
//  PizzaParty
//
//  Created by Erik Hede on 2019-02-26.
//  Copyright © 2019 Erik Hede. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {
    
    var restaurantID : Int!
    
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantID = MenuList.pizzaList[0].fromPizzeria
        restaurantNameLabel.text = ListOfRestaurants.listOfRestaurants[restaurantID-1].name
    }
    
}
extension MenuVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return MenuList.pizzaList.count + MenuList.sidesList.count
        return MenuList.pizzaList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let pizzaCell = Bundle.main.loadNibNamed("PizzaCell", owner: self, options: nil)?.first as? PizzaCell else {
            return UITableViewCell()
        }
        pizzaCell.setPizzaInfo(menuItem: MenuList.pizzaList[indexPath.row])
        return pizzaCell
        
    }
    
    
    
}
