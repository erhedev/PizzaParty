//
//  ClosestPizzeriaVC.swift
//  PizzaParty
//
//  Created by Erik Hede on 2019-02-20.
//  Copyright © 2019 Erik Hede. All rights reserved.
//

import UIKit
import CoreLocation
import SVProgressHUD
import Alamofire

class ClosestPizzeriaVC: UIViewController {

    //LocationManager
    var locationManager = CLLocationManager()
    
    var pizzeriaDelegate: PizzeriaCellDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // prepare for segue to menu vc or to basket.
    }
    

}

extension ClosestPizzeriaVC: PizzeriaCellDelegate {
    func didTapSeeMenu(id: Int) {
        <#code#>
    }
    
    //implement did tap menu bytton
}

//Tableview delegate extension
extension ClosestPizzeriaVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ListOfRestaurants.listOfRestaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}
