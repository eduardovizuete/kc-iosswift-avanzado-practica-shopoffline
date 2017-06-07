//
//  ShopListCellCollectionViewCell.swift
//  ShopsOnlinePractica
//
//  Created by usuario on 6/6/17.
//  Copyright © 2017 evizcloud. All rights reserved.
//

import UIKit

class ShopListCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var image: UIImageView!
    
    var _coreShop: CoreShop? = nil
    
    var coreShop: CoreShop {
        
        get {
            return _coreShop!
        }
        
        set {
            _coreShop = newValue
            nameLabel.text = newValue.name
        }
    }
    
    
}
