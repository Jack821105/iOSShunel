//
//  ProductDetailViewController.swift
//  iOSShunel
//
//  Created by 許自翔 on 2020/9/20.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    //     宣告區
    
    @IBOutlet weak var ProductImage: UIImageView!
    
    @IBOutlet weak var ProductName: UILabel!
    
    @IBOutlet weak var ProductColor: UILabel!
    
    @IBOutlet weak var ProductPrice: UILabel!
    
    @IBOutlet weak var ProductDitail: UILabel!
    
    var productDetail:Product?
    var shopCar:Shopping_Cart?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        ProductName.text = productDetail?.product_Name
        ProductColor.text = productDetail?.product_Color
        ProductPrice.text = String(productDetail?.product_Price ?? 0)
        ProductDitail.text = productDetail?.product_Ditail
        
        shopCar = Shopping_Cart(product_ID: productDetail!.product_ID, product_Name: productDetail!.product_Name, product_Color: productDetail!.product_Color, product_Price: productDetail!.product_Price, product_Ditail: productDetail!.product_Ditail, product_Status: productDetail!.product_Status,account_ID: "13")
        
        
        NetworkController.shared.getImageView(productID:productDetail!) { (image) in
            
            DispatchQueue.main.async {
                if image != nil{
                    self.ProductImage.image = image
                }
            }
        }
        
        
    }
    
    @IBAction func actionAddShopCar(_ sender: Any) {
        
        NetworkController.shared.addShop(shoppingCartOut:shopCar!) { (count) in
            
            if count == 1{
                print("成功")
            }else{
                print("失敗")
            }
            
        }
        
    }
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
