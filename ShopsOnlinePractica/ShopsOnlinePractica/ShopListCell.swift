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
            
            // load cache local image
            let fileName = newValue.logoFileHash
            
            print("Cargando: " + fileName!)
            
            let fm = FileManager.default
            let urls = fm.urls(for: .cachesDirectory, in: .userDomainMask)
            
            guard let url = urls.last?.appendingPathComponent("AsyncData.Type") else {
                fatalError("Unable to create url for local storage at \(urls)")
            }
            
            let localFile = url.appendingPathComponent(fileName!)
            
            print("Cargando: " + localFile.absoluteString)
            
            let data = NSData(contentsOf: localFile)
            
            if data != nil {
                image.image = UIImage(data: data as! Data)
            } else {
                let mainBundle = Bundle.main
                let defaultImage = mainBundle.url(forResource: "emptyBookCover", withExtension: "png")!
                
                image.image = UIImage(data: try! Data(contentsOf: defaultImage))
            }
        }
    }
    
    
}
