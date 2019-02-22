//
//  FetchData.swift
//  PizzaParty
//
//  Created by Erik Hede on 2019-02-20.
//  Copyright © 2019 Erik Hede. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SVProgressHUD


class FetchData {
//    //Pizza API baseadress
//    static let pizzaAPI : String = "https://private-anon-f2ba0bf1fe-pizzaapp.apiary-mock.com/"
//    //Pizza API Endpoints
//    static let restaurants : String = "restaurants/"
//    static let menu : String = "menu/"
//    static let orders : String = "orders/"


    
    func fetchRestaurantData() {

        let allrestaurants = "\(pizzaAPI)\(restaurants)"
        ListOfRestaurants.listOfRestaurants.removeAll()
        checkIfInternetIsAvalible(type: "restaurants")
        print(allrestaurants)
        Alamofire.request(allrestaurants, method: .get).validate().responseJSON { response in
            if response.result.isSuccess {
                print("fetched all restaurants")
                SVProgressHUD.dismiss()
                let restaurantData : JSON = JSON(response.result.value!)
                JSONParsing.parseRestaurant(json: restaurantData)
            } else {
                print("Error \(String(describing: response.result.error))")
            }
        }
    
    }
    
    func fetchMenuForRestaurant(id: Int) {
        let menuData = "\(pizzaAPI)\(restaurants)\(id)\(menu)"
        //fetch and parse data from api
        checkIfInternetIsAvalible(type: "menu")
        print(menuData)
        Alamofire.request(menuData, method: .get).validate().responseJSON { response in
            if response.result.isSuccess {
                print("Fetched menu for restaurant with id: \(id)")
                SVProgressHUD.dismiss()
                let menuData : JSON = JSON(response.result.value!)
                JSONParsing.parseMenu(json: menuData)
            } else {
                print("Error \(String(describing: response.result.error))")
            }
        }
        
    }
    
    
    func checkIfInternetIsAvalible(type: String) {
        if isConnectedToInternet() {
            print("You have the Internetz!")
            SVProgressHUD.show(withStatus: "Downloading \(type)")
        } else {
            print("Pity the fool!")
            SVProgressHUD.dismiss()
            SVProgressHUD.setMaximumDismissTimeInterval(7)
            SVProgressHUD.showError(withStatus: "You don't have Internetz Connection")
            SVProgressHUD.setMaximumDismissTimeInterval(1)
        }
    }
    
    // MARK: - Helpers
    
    func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    
}
