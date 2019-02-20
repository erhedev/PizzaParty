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
        
        Alamofire.request(allrestaurants, method: .get).validate().responseJSON { response in
            if response.result.isSuccess {
                print("fetched all restaurants")
                let restaurantData : JSON = JSON(response.result.value!)
                JSONParsing.parseRestaurant(json: restaurantData)
            } else {
                print("Error \(String(describing: response.result.error))")
            }
            
        }
        
    
        
//        Alamofire.request(allrestaurants, method: .get).validate().responseJSON { response in
//            if response.result.isSuccess {
//                print("Got the info")
//                let feedData : JSON = JSON(response.result.value!)
//                JSONParsing.parsing(json: feedData, date: date)
//            } else {
//                print("Error \(response.result.error)")
//            }
//        }
    }
    
    
    func checkIfInternetIsAvalible(type: String) {
        if isConnectedToInternet() {
            print("You have the Internetz!")
            SVProgressHUD.show(withStatus: "Downloading \(type)")
        } else {
            print("Pity the fool!")
            //            errorMessageInTableView = "You don't have any Internet Connection"
            //            SVProgressHUD.dismiss()
            SVProgressHUD.setMaximumDismissTimeInterval(7)
            SVProgressHUD.showError(withStatus: "Pity the fool! You don't have any Internetz Connection")
            SVProgressHUD.setMaximumDismissTimeInterval(1)
        }
    }
    
    // MARK: - Helpers
    
    func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    
}
