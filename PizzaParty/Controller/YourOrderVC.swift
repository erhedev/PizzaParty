//
//  YourOrderVC.swift
//  PizzaParty
//
//  Created by Erik Hede on 2019-02-26.
//  Copyright © 2019 Erik Hede. All rights reserved.
//

import UIKit

class YourOrderVC: UIViewController {

    @IBOutlet weak var orderTableView: UITableView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var placeOrderButton: UIButton!
    @IBOutlet weak var checkOrderButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideAndDisableButton(button: checkOrderButton)
        
        // Do any additional setup after loading the view.
    }
    
    func hideAndDisableButton(button: UIButton) {
        button.isEnabled = false
        button.isHidden = true
    }
    
    func showAndActivateButton(button: UIButton) {
        button.isEnabled = true
        button.isHidden = false
    }
    
    @IBAction func placeOrderPressed(_ sender: Any) {
        
    }
 
    @IBAction func cheCKOrderStatusPressed(_ sender: Any) {
        
    }
   
    @IBAction func backButtonPressed(_ sender: Any) {
        
    }
    
}

extension YourOrderVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuList.menuItemsToOrder.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let pizzaCell = Bundle.main.loadNibNamed("PizzaCell", owner: self, options: nil)?.first as? PizzaCell else {
            return UITableViewCell()
        }
        pizzaCell.setPizzaInfo(menuItem: MenuList.menuItemsToOrder[indexPath.row])
        hideAndDisableButton(button: pizzaCell.orderButton)
        return pizzaCell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            MenuList.menuItemsToOrder.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    
}
