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
  
    var restaurantListSortedOnDistance = [Restaurant]()
    
    
    @IBOutlet weak var restaurantTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Allow Device to track location
        self.locationManager.requestWhenInUseAuthorization()
        
        //Track location if enabled
        if CLLocationManager.locationServicesEnabled() {
            
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        datafetcher.fetchRestaurantData(completionHandler: { result in
            
            switch result {
            case .success(let value):
                debugPrint("hmm")
                print(value)
                self.restaurantList = value
                // Ta bort loading
                DispatchQueue.main.async {
                    self.reloadDataStartTableView()
                }
                SVProgressHUD.dismiss()
            case .loading:
                debugPrint("loading")
                // Visa loading
            case .failure(let error):
                // Visa error
                debugPrint(error.localizedDescription)
            }
            
        })
        
        
    }
    
    func sortOnDistance(list: [Restaurant]) -> [Restaurant] {
        let sortedList = list.sorted(by: {$0.distanceFromDevice > $1.distanceFromDevice})
        return sortedList
    }
    
     func reloadDataStartTableView() {
        //sort list on distance
        restaurantListSortedOnDistance = sortOnDistance(list: restaurantList)
        
        print(restaurantListSortedOnDistance[0].name)
        print(restaurantList[0].name)
        
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
        
        let name = restaurantList[id-1].getName()
        
        debugPrint("Name\(name)")
        
        MenuVC.restaurantID = id
        MenuVC.name = name
        
        goToMenu()
    }
    
    
func goToMenu() {
    let menuVC = storyboard?.instantiateViewController(withIdentifier: "MenuVC") as! MenuVC
    present(menuVC, animated: true, completion: nil)
    
    }
}

//Tableviewdelegate extension
extension ClosestPizzeriaVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("List Count:  \(ListOfRestaurants.listOfRestaurants.count)")
        return restaurantList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let restaurant = restaurantList[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PizzeriaCell") as? PizzeriaCell else {
            fatalError()
        }
        cell.setPizzeriaInfo(restaurant: restaurant, deviceLocation: ClosestPizzeriaVC.deviceLocation)
        cell.delegate = self
        return cell

    }
    
}



