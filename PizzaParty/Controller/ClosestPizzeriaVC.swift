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

class ClosestPizzeriaVC: UIViewController, CLLocationManagerDelegate {

    //LocationManager
    var locationManager = CLLocationManager()
    
    static var deviceLocation : CLLocation!
    
    var pizzeriaDelegate: PizzeriaCellDelegate?
    
    var datafetcher = DataTransfer()
    
    var restaurantList = [Restaurant]()
    
    @IBOutlet weak var restaurantTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadDataStartTableView(notification:)), name: .doneParsingRestaurants, object: nil)
        
        //Allow Device to track location
        self.locationManager.requestWhenInUseAuthorization()
        
        //Track location if enabled
        if CLLocationManager.locationServicesEnabled() {
            
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        datafetcher.fetchRestaurantData()
        
    }
    
    @objc func reloadDataStartTableView(notification: NSNotification) {
        print(ListOfRestaurants.listOfRestaurants[0].name)
        
        
        //sort list on distance
        restaurantList = ListOfRestaurants.listOfRestaurants.sorted(by: {$0.distanceFromDevice < $1.distanceFromDevice})
        
        restaurantTableView.reloadData()
        SVProgressHUD.dismiss()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        ClosestPizzeriaVC.deviceLocation = locations.last
        print("deviceLocation: \(String(describing: ClosestPizzeriaVC.deviceLocation))")
    }
    

}

extension ClosestPizzeriaVC: PizzeriaCellDelegate {
    func didTapSeeMenu(id: Int) {
        print("tapped \(id)")
        MenuList.pizzaList.removeAll()
        MenuList.sidesList.removeAll()
        
        // fetch clicked cells menu
        datafetcher.fetchMenuForRestaurant(id: id)
        // listen for parsing to be done
        NotificationCenter.default.addObserver(self, selector: #selector(goToMenu(notification:)), name: .doneParsingMenu, object: nil)
        
        // present menu in table view
    }
    
    @objc func goToMenu(notification: NSNotification) {
        print(MenuList.pizzaList[0].name)
        performSegue(withIdentifier: "goToMenu", sender: self)
        SVProgressHUD.dismiss()
    }
    
    
}

//Tableviewdelegate extension
extension ClosestPizzeriaVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("List Count:  \(ListOfRestaurants.listOfRestaurants.count)")
        return ListOfRestaurants.listOfRestaurants.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let restaurant = restaurantList[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PizzeriaCell") as? PizzeriaCell else {
            return UITableViewCell()
        }
        cell.setPizzeriaInfo(restaurant: restaurant, deviceLocation: ClosestPizzeriaVC.deviceLocation)
        cell.delegate = self
        return cell

    }
    
}

extension Notification.Name {
    static let doneParsingRestaurants = Notification.Name("doneParsingRestaurants")
    static let doneParsingMenu = Notification.Name("doneParsingMenu")
}
