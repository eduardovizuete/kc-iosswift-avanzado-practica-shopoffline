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

    var context: NSManagedObjectContext?
    
    var _fetchedResultsController: NSFetchedResultsController<CoreShop>? = nil
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ShopListViewController cargado")
    }
}
