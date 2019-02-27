//
//  YourOrderVC.swift
//  PizzaParty
//
//  Created by Erik Hede on 2019-02-26.
//  Copyright © 2019 Erik Hede. All rights reserved.
//

import UIKit
import SVProgressHUD

class YourOrderVC: UIViewController {
    
    var restaurantID : Int!
    var dataHandler = DataTransfer()
    static var orderID : Int!
    
    
    @IBOutlet weak var orderTableView: UITableView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var placeOrderButton: UIButton!
    @IBOutlet weak var checkOrderButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(prepareForOrderStatus(notification:)), name: .doneParsingOrderStatus, object: nil)
        
        hideAndDisableButton(button: checkOrderButton)
        
        restaurantID = MenuList.pizzaList[0].fromPizzeria
        
        restaurantNameLabel.text = ListOfRestaurants.listOfRestaurants[restaurantID-1].name
        
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
    
    func placeOrder() {
        let order = Order(cart: MenuList.itemsToOrder, restuarantId: MenuList.pizzaList[0].fromPizzeria)
        
        dataHandler.postOrder(order: order)
        
        NotificationCenter.default.addObserver(self, selector: #selector(parseOrderStatus(notification:)), name: .orderPosted, object: nil)
        
    }
    
    @objc func prepareForOrderStatus(notification: NSNotification) {
        hideAndDisableButton(button: placeOrderButton)
        showAndActivateButton(button: checkOrderButton)
    }
    
    @objc func parseOrderStatus(notification: NSNotification) {
        dataHandler.fetchOrderStatus(orderID: (StatusVC.orderStatus?.orderID)!)
    }
    
    @IBAction func placeOrderPressed(_ sender: Any) {
        placeOrder()
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

    
extension Notification.Name {
    static let orderPosted = Notification.Name("orderPosted")
    static let doneParsingOrderStatus = Notification.Name("doneParsingOrderStatus")
}

