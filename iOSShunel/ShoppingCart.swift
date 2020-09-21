//
//  ShoppingCart.swift
//  iOSShunel
//
//  Created by 許自翔 on 2020/9/21.
//

import Foundation


struct Shopping_Cart:Codable {
    
    let product_ID:Int
    let product_Name:String
    let product_Color:String
    let product_Price:Int
    let product_Ditail:String
    let product_Status:Int
    let account_ID:String
    
    
    
    init(product_ID:Int , product_Name:String,product_Color:String, product_Price:Int
         ,product_Ditail:String,product_Status:Int,account_ID:String) {
        self.product_ID = product_ID
        self.product_Name = product_Name
        self.product_Color = product_Color
        self.product_Ditail = product_Ditail
        self.product_Price = product_Price
        self.product_Status = product_Status
        self.account_ID = account_ID
    }
    
}

