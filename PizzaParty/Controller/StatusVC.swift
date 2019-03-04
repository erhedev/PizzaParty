//
//  StatusVC.swift
//  PizzaParty
//
//  Created by Erik Hede on 2019-02-26.
//  Copyright © 2019 Erik Hede. All rights reserved.
//

import UIKit
import SVProgressHUD

class StatusVC: UIViewController {
    
//    static var orderStatus : OrderStatus?
    static var orderId : Int?
    
    var dataFetcher = DataTransfer()

    @IBOutlet weak var orderStatusLabel: UILabel!
    @IBOutlet weak var orderedTimeLabel: UILabel!
    @IBOutlet weak var deliveryTimeLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show()
        setLabelNames()
        SVProgressHUD.dismiss()
        
    }
    
    func setLabelNames() {
        orderStatusLabel.text = MenuList.orderStatuses[0].status
        orderedTimeLabel.text = MenuList.orderStatuses[0].orderedAt
        deliveryTimeLabel.text = MenuList.orderStatuses[0].estimatedDelivery
        totalPriceLabel.text = String(MenuList.orderStatuses[0].totalPrice)
}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToOrder" {
            let yourOrderVC = segue.destination as! YourOrderVC
            yourOrderVC.placeOrderButtonIsHidden = true
        }
    }
    
    
    
    @IBAction func updateStatusPressed(_ sender: Any) {
        
        let orderId = StatusVC.orderId
        
        dataFetcher.fetchOrderStatus(orderID: orderId!)
        
        setLabelNames()
        
    }
    
}

