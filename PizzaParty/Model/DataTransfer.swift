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
    
    let apiStrings = Constants()
    
    
    enum Result<Value> {
        
        case success(Value)
        case loading
        case failure(Error)
        
    }
    
    func fetchRestaurantData(completionHandler:@escaping (Result<[Restaurant]>) -> Void) {
        
        completionHandler(Result.loading)
        
        let allrestaurantsURL = "\(apiStrings.pizzeriaAPI)\(apiStrings.restaurants)"
        checkIfInternetIsAvalible(type: "restaurants")
        print(allrestaurantsURL)
        Alamofire.request(allrestaurantsURL, method: .get).validate().responseJSON { response in
            
            switch response.result {
            case .success(let value):
                let restaurantData : JSON = JSON(value)
                let data = JSONParsing.parseRestaurant(json: restaurantData)
                completionHandler(Result.success(data))
                return
            case .failure(let error):
                completionHandler(Result.failure(error))
            }
            
        }
    }
    
    func fetchMenuForRestaurant(completionHandler: @escaping (Result<[MenuItem]>) -> Void, id: Int) {
        
        
        completionHandler(Result.loading)
        
        let menuURL = "\(apiStrings.menuAPI)\(apiStrings.restaurants)\(id)\(apiStrings.menu)"
        print(menuURL)
        checkIfInternetIsAvalible(type: "menu")
        Alamofire.request(menuURL, method: .get).validate().responseJSON { response in
            
            switch response.result {
            case .success(let value):
                let menuData : JSON = JSON(value)
                let data = JSONParsing.parseMenu(json: menuData, restaurantID: id)
                completionHandler(Result.success(data))
                return
            case .failure(let error):
                completionHandler(Result.failure(error))
            }
            
        }
    }
    
    
    func fetchOrderStatus(completionHandler: @escaping (Result<OrderStatus>) -> Void, orderID: Int)  {
        
        completionHandler(Result.loading)
        
        let orderURL = "\(apiStrings.menuAPI)\(apiStrings.orders)\(orderID)"
        checkIfInternetIsAvalible(type: "order Status")
        Alamofire.request(orderURL, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let orderData : JSON = JSON(value)
                let data = JSONParsing.parseOrderStatus(json: orderData)
                completionHandler(Result.success(data))
                return
            case .failure(let error):
                completionHandler(Result.failure(error))
            }
        }
        
    }
    
    func postOrder(order: Order) {
        let orderURL = "\(apiStrings.menuAPI)\(apiStrings.orders)"
        
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
                    print("json \(json)")
                    
                    if let jsonData = try? JSONSerialization.data(withJSONObject:json) {
                        let status = try JSONDecoder().decode(OrderStatusResponse.self, from: jsonData)
                        print(status.orderId)
                        StatusVC.orderId = status.orderId
                        let orderStatus = OrderStatus(orderID: status.orderId, totalPrice: status.totalPrice, orderedAt: status.orderedAt, estDel: status.esitmatedDelivery, status: status.status)
                        MenuList.orderStatuses.append(orderStatus)
                        print(MenuList.orderStatuses[0].status)
                    }
                
                } catch {
                    print(error)
                }
            }
            SVProgressHUD.dismiss()
            }.resume()
        
//        NotificationCenter.default.post(name: .orderPosted, object: nil)
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
    
    

