//
//  Product.swift
//  iOSShunel
//
//  Created by 許自翔 on 2020/9/12.
//

import Foundation

struct Product:Codable {
    let product_ID:Int
    let product_Name:String
    let product_Color:String
    let product_Price:Int
    let product_Ditail:String
    let product_Category_ID:Int
    let product_Status:Int
}
