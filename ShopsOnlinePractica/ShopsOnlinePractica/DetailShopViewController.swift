//
//  DetailShopViewController.swift
//  ShopsOnlinePractica
//
//  Created by usuario on 6/10/17.
//  Copyright © 2017 evizcloud. All rights reserved.
//

import UIKit

class DetailShopViewController: UIViewController {
    
    var shopName: String = ""
    var desc: String = ""
    var address: String = ""
    var mapHash: String = ""

    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var mapImageView: UIImageView!
    
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = shopName
        descLabel.text = desc
        addressLabel.text = address
        
        // load cache local image
        let fileName = mapHash
        
        print("Cargando: " + fileName)
        
        let fm = FileManager.default
        let urls = fm.urls(for: .cachesDirectory, in: .userDomainMask)
        
        guard let url = urls.last?.appendingPathComponent("AsyncData.Type") else {
            fatalError("Unable to create url for local storage at \(urls)")
        }
        
        let localFile = url.appendingPathComponent(fileName)
        
        print("Cargando: " + localFile.absoluteString)
        
        let data = NSData(contentsOf: localFile)
        
        if data != nil {
            mapImageView.image = UIImage(data: data as! Data)
        } else {
            let mainBundle = Bundle.main
            let defaultImage = mainBundle.url(forResource: "madrid_shops", withExtension: "png")!
            
            mapImageView.image = UIImage(data: try! Data(contentsOf: defaultImage))
        }
    }

}
