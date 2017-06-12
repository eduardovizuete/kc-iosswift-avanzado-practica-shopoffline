//
//  ShopListViewController.swift
//  ShopsOnlinePractica
//
//  Created by usuario on 6/6/17.
//  Copyright © 2017 evizcloud. All rights reserved.
//

import UIKit
import CoreData

class ShopListViewController: UIViewController {
    
    var shopName: String = ""
    var desc: String = ""
    var address: String = ""
    var mapHash: String = ""

    var context: NSManagedObjectContext? {
        didSet {
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
        }
    }
    
    var _fetchedResultsController: NSFetchedResultsController<CoreShop>? = nil
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ShopListViewController cargado")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailViewController = segue.destination as! DetailShopViewController
        
        detailViewController.shopName = shopName
        detailViewController.desc = desc
        detailViewController.address = address
        detailViewController.mapHash = mapHash
        
        print("presentar detalle")
    }

}
