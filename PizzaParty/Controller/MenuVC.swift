//
//  MenuVC.swift
//  PizzaParty
//
//  Created by Erik Hede on 2019-02-26.
//  Copyright © 2019 Erik Hede. All rights reserved.
//

import UIKit
import SVProgressHUD

class MenuVC: UIViewController {
        
    var dataFetcher = DataTransfer()
    
    static var  restaurantID : Int?
    
    static var name : String?
    
    var menuList = [MenuItem]()
    
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // fixa idt till rätt restaurang

            dataFetcher.fetchMenuForRestaurant(completionHandler: { result in
                switch result {
                case .success(let value):
                    debugPrint("success fetching menu")
                    print(value)
                    self.menuList = value
                    self.reloadDataStartTableView()
                    // load tableview
                // dismiss spinner
                case .loading:
                    debugPrint("Loading Menu")
                    // Visa Spinner
                    SVProgressHUD.show(withStatus: "Loading Menu")
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    SVProgressHUD.showError(withStatus: "No menu To Show")
                }
            }, id: MenuVC.restaurantID!)
        
        restaurantNameLabel.text = MenuVC.name!
        
    }
    
    
    func reloadDataStartTableView() {
        menuTableView.reloadData()
        SVProgressHUD.dismiss()
    }
    
}
extension MenuVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let itemCell = Bundle.main.loadNibNamed("PizzaCell", owner: self, options: nil)?.first as? PizzaCell else {
            return UITableViewCell()
        }
        itemCell.setPizzaInfo(menuItem: menuList[indexPath.row])
        return itemCell
        
    }
}
