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


class DataTransfer {
//    //Pizza API baseadress
//    static let pizzaAPI : String = "https://private-anon-f2ba0bf1fe-pizzaapp.apiary-mock.com/"
//    //Pizza API Endpoints
//    static let restaurants : String = "restaurants/"
//    static let menu : String = "menu/"
//    static let orders : String = "orders/"
    
    
    func fetchRestaurantData() {
        let allrestaurantsURL = "\(pizzeriaAPI)\(restaurants)"
        ListOfRestaurants.listOfRestaurants.removeAll()
        checkIfInternetIsAvalible(type: "restaurants")
        print(allrestaurantsURL)
        Alamofire.request(allrestaurantsURL, method: .get).validate().responseJSON { response in
            if response.result.isSuccess {
                print("fetched all restaurants")
                let restaurantData : JSON = JSON(response.result.value!)
                JSONParsing.parseRestaurant(json: restaurantData)
                SVProgressHUD.dismiss()
            } else {
                print("Error \(String(describing: response.result.error))")
            }
        }
    }
    
    func fetchMenuForRestaurant(id: Int) {
        let menuURL = "\(menuAPI)\(restaurants)\(id)\(menu)"
        print(menuURL)
        //fetch and parse data from api
        checkIfInternetIsAvalible(type: "menu")
        print(menuURL)
        Alamofire.request(menuURL, method: .get).validate().responseJSON { response in
            if response.result.isSuccess {
                print("Fetched menu for restaurant with id: \(id)")
                let menuData : JSON = JSON(response.result.value!)
                JSONParsing.parseMenu(json: menuData, restaurantID: id)
                SVProgressHUD.dismiss()
            } else {
                print("Error \(String(describing: response.result.error))")
            }
        }
    }
    
    func fetchOrderStatus(orderID: Int)  {
        let orderURL = "\(menuAPI)\(orders)\(orderID)"
        checkIfInternetIsAvalible(type: "order Status")
        Alamofire.request(orderURL, method: .get).validate().responseJSON { response in
            if response.result.isSuccess {
                print("Fetched Order Status for order: \(orderID)")
                SVProgressHUD.dismiss()
                let orderStatusData : JSON = JSON(response.result.value!)
                JSONParsing.parseOrderStatus(json: orderStatusData)
                
            } else {
                print("Error \(String(describing: response.result.error))")
            }
        }
        
        
    }
    
    func postOrder(order: Order) {
        let orderURL = "\(menuAPI)\(orders)"
        
        print(order)
        
        let parameters = ["menuItemId" :"1", "quantity":"1"]
        
        checkIfInternetIsAvalible(type: "order")
        
        guard let url = URL(string: orderURL) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print("response: \(response)")
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                    
                    if let jsonData = try? JSONSerialization.data(withJSONObject:json) {
                        let status = try JSONDecoder().decode(OrderStatusResponse.self, from: jsonData)
                        print(status.orderId)
                        StatusVC.orderId = status.orderId
                    }
                

                } catch {
                    print(error)
                }
            }
            SVProgressHUD.dismiss()
            }.resume()
        
        NotificationCenter.default.post(name: .orderPosted, object: nil)
    }
    
    func checkIfInternetIsAvalible(type: String) {
        if isConnectedToInternet() {
            print("You have Internet!")
            if type == "order" {
                SVProgressHUD.show(withStatus: "Placing \(type)")
            } else {
                SVProgressHUD.show(withStatus: "Downloading \(type)")
            }
            
        } else {
            print("Pity the fool!")
            SVProgressHUD.dismiss()
            SVProgressHUD.setMaximumDismissTimeInterval(7)
            SVProgressHUD.showError(withStatus: "You don't have Internet Connection")
            SVProgressHUD.setMaximumDismissTimeInterval(1)
        }
    }
    
    // MARK: - Helpers
    
    func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }

}
    
    

