//
//  MenuVC.swift
//  PizzaParty
//
//  Created by Erik Hede on 2019-02-26.
//  Copyright © 2019 Erik Hede. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {
    
    var closest = ClosestPizzeriaVC()
    
    var dataFetcher = DataTransfer()
    
    var restaurantID : Int!
    
    var menuList = [MenuItem]()
    
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        restaurantID = MenuList.pizzaList[0].fromPizzeria
//        restaurantNameLabel.text = ListOfRestaurants.listOfRestaurants[restaurantID-1].name
        
        // fixa idt till rätt restaurang
        restaurantID = closest.restaurantList[0].id
        
        dataFetcher.fetchMenuForRestaurant(completionHandler: { result in
            switch result {
            case .success(let value):
                debugPrint("success fetching menu")
                print(value)
                self.menuList = value
                // load tableview
                // dismiss spinner
            case .loading:
                debugPrint("Loading Menu")
                // Visa Spinner
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }, id: restaurantID)
        
    }
        
}
extension MenuVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuList.pizzaList.count + MenuList.sidesList.count
        //        return MenuList.pizzaList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row < MenuList.pizzaList.count {
            guard let pizzaCell = Bundle.main.loadNibNamed("PizzaCell", owner: self, options: nil)?.first as? PizzaCell else {
                return UITableViewCell()
            }
            pizzaCell.setPizzaInfo(menuItem: MenuList.pizzaList[indexPath.row])
            return pizzaCell
        } else {
            guard let menuItemCell = Bundle.main.loadNibNamed("MenuItemCell", owner: self, options: nil)?.first as? MenuItemCell else {
                return UITableViewCell()
            }
            menuItemCell.setMenuItemInfo(menuItem: MenuList.sidesList[indexPath.row-MenuList.pizzaList.count])
            return menuItemCell
        }
    }
}
