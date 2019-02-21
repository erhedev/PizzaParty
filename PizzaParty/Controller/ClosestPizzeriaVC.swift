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
    
    var deviceLocation : CLLocation!
    
    var pizzeriaDelegate: PizzeriaCellDelegate?
    
    var datafetcher = FetchData()
    
    var restaurantList = ListOfRestaurants.listOfRestaurants
    
    @IBOutlet weak var restaurantTableView: UITableView!
    
    @IBOutlet weak var cartButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        datafetcher.fetchRestaurantData()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // prepare for segue to menu vc or to basket.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        deviceLocation = locations.last
    }
    

}

extension ClosestPizzeriaVC: PizzeriaCellDelegate {
    func didTapSeeMenu(id: Int) {
        print("tapped \(id)")

    }

    //implement did tap menu bytton
}

//Tableviewdelegate extension
extension ClosestPizzeriaVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("List Count:  \(ListOfRestaurants.listOfRestaurants.count)")
        return ListOfRestaurants.listOfRestaurants.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let restaurant = ListOfRestaurants.listOfRestaurants[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PizzeriaCell") as! PizzeriaCell
        cell.setPizzeriaInfo(restaurant: restaurant, location: deviceLocation)
        cell.delegate = self
        return cell

    }
}

extension Notification.Name {
    static let doneParsing = Notification.Name("doneParsing")
}
