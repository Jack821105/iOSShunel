//
//  NetworkController.swift
//  iOSShunel
//
//  Created by 許自翔 on 2020/9/12.
//

import Foundation
import UIKit

class NetworkController{
    
    static let shared = NetworkController()
    
    let urlBase = URL(string: "http://localhost:8080/Shunel_Web")!
    
    
    /*GetAll*/
    func getAllProduct( completion: @escaping ([Product]) -> Void) {
        
        var product = [Product]()
        struct keyValue:Codable{
            var action = "getAll"
        }
        
        let url = urlBase.appendingPathComponent("Prouct_Servlet")
        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let encoder = JSONEncoder()
        req.httpBody = try? JSONEncoder().encode(keyValue())
        URLSession.shared.dataTask(with: req) { (data, response, error) in
            if let error = error{
                print("Error: \(error.localizedDescription)")
            }else if let response = response,let data = data{
                print("狀態:\(response)")
                let decoder = JSONDecoder()
                if let finalData = try? decoder.decode([Product].self, from: data) {
                    product = finalData
                    completion(product)
                }
            }
        }.resume()
    }
    /*---------------------------------------------------------------------------------------------------------------*/
    
    /*GetImageView*/
    func getImageView(productID ProductID:Product, completion: @escaping (UIImage?) -> Void) {
        
        struct keyValue:Codable{
            var action:String
            var id:Int
            var imageSize:Int
        }
        
        let url = urlBase.appendingPathComponent("Prouct_Servlet")
        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //        let encoder = JSONEncoder()
        req.httpBody = try? JSONEncoder().encode(keyValue(action: "getImage", id:ProductID.product_ID , imageSize: 300))
        URLSession.shared.dataTask(with: req) { (data, response, error) in
            if let error = error{
                print("Error: \(error.localizedDescription)")
            }else if let response = response,let data = data{
                if let data = UIImage(data: data) {
                    completion(data)
                }else{
                    completion(nil)
                }
                
            }
        }.resume()
        
        
        
        
        
    }
    /*---------------------------------------------------------------------------------------------------------------*/
    
    
    /*addShop*/
    func addShop(shoppingCartOut shoppingCarIn:Shopping_Cart ,completion: @escaping (Int) -> Void) {
        
        let shoppingCar = shoppingCarIn
        
        
        struct keyValue:Encodable{
            var action:String
            var ProductID:Shopping_Cart?
            enum CodingKeys: String,CodingKey {
                case action
                case ProductID
                
            }

            func encode(to encoder: Encoder) throws {
                var container = encoder.container(keyedBy: CodingKeys.self)
                try container.encode(action, forKey: .action)
                if let missionData = try? JSONEncoder().encode(ProductID), let missionString = String(data: missionData, encoding: .utf8) {
                    try container.encode(missionString, forKey: .ProductID)
                }
               
            }
            
        }
        
        let url = urlBase.appendingPathComponent("Prouct_Servlet")
        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let encoder = JSONEncoder()
        req.httpBody = try? JSONEncoder().encode(keyValue(action: "addShop", ProductID: shoppingCar))
        URLSession.shared.dataTask(with: req) { (data, response, error) in
            if let error = error{
                print("Error: \(error.localizedDescription)")
            }else if let response = response,let data = data{
                print("狀態:\(response)")
                let decoder = JSONDecoder()
                if let finalData = try? decoder.decode(Int.self, from: data) {
                    completion(finalData)
                }
            }
        }.resume()
    }
    
    
    
}
