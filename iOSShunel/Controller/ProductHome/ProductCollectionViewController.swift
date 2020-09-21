//
//  ProductCollectionViewController.swift
//  iOSShunel
//
//  Created by 許自翔 on 2020/9/12.
//

import UIKit

private let reuseIdentifier = "Cell"

class ProductCollectionViewController: UICollectionViewController {
    
    
    var showProduct = [Product]()
    var productView : UIImage?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        //控制cell
        let itemSpace: CGFloat = 3
               let columnCount: CGFloat = 2
               let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout
               let width = floor((collectionView.bounds.width  - itemSpace * (columnCount-1)) / columnCount)
        print("width",width, collectionView.bounds)
                flowLayout?.itemSize = CGSize(width: width, height: width)
               flowLayout?.estimatedItemSize = .zero
               flowLayout?.minimumInteritemSpacing = itemSpace
               flowLayout?.minimumLineSpacing = itemSpace
        
        
        flowLayout?.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        
        
        
        NetworkController.shared.getAllProduct { (getProduct: [Product]?) in
            if let getProduct = getProduct{
                self.showProduct = getProduct
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
       
        
       
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
        return showProduct.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ProductCollectionViewCell.self)", for: indexPath) as? ProductCollectionViewCell
        
       let product = showProduct[indexPath.item]
        NetworkController.shared.getImageView(productID:product) { (image) in
           
            DispatchQueue.main.async {
                if image != nil{
                    cell?.productImageView.image = image!
                }
            }
            
        }
        
        
        if let cell = cell {
            print("1")
            return cell
        }else{
            print("2")
            return UICollectionViewCell()
        }
    }
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
    @IBSegueAction func actionPorductToDetail(_ coder: NSCoder) -> ProductDetailViewController? {
        let controller = ProductDetailViewController(coder: coder)
        
        if let row = collectionView.indexPathsForSelectedItems?.first?.row {
            controller?.productDetail = showProduct[row]
        }
        
        return controller
    }
}
