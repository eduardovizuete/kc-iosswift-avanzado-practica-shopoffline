//
//  AppDelegate.swift
//  ShopsOnlinePractica
//
//  Created by usuario on 5/11/17.
//  Copyright © 2017 evizcloud. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var context: NSManagedObjectContext?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Initialize core data manager
        let container = persistentContainer(dbName: "ShopsOnlinePractica") { (error: NSError) in
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
        
        // ckeck download data from internet to local
        UserDefaults.standard.register(defaults:
            [
                "loadDataFromInternet": false
            ]
        )
        
        let loadData = UserDefaults.standard.bool(forKey: "loadDataFromInternet")
        print(loadData)
        
        if !loadData {	
            // Download data from internet to json and save in model core data
            DispatchQueue.global(qos: .default).async {
                self.downloadDataFromNetToJson(container: container.viewContext)
            }
        }
        
        self.context = container.viewContext
        
        return true
    }
    
    func injectContextToFirstViewController() {
        if let navController = window?.rootViewController as? UINavigationController,
            let initialViewController = navController.topViewController as? ShopListViewController
        {
            initialViewController.context = self.context
        }
    }
    
    func downloadDataFromJson(container: NSManagedObjectContext) {
        // Clean up all local caches
        AsyncData.removeAllLocalFiles()
        
        do{
            // Descargar los datos desde internet
            let urlJSONFile = "http://madrid-shops.com/json_new/getShops.php"
            let jsonFile = try? Data(contentsOf: URL(string: urlJSONFile)!)
            
            guard let downloadData = jsonFile else {
                fatalError("Unable to read json file!")
            }

            let jsonData = try JSONSerialization.jsonObject(with: downloadData, options: .allowFragments) as? JSONArray
            
            let shops = try decode(shops: jsonData)
            loadDataIntoModelCoreData(dataList: shops, context: container)
        }catch {
            fatalError("Error while loading model")
        }
        
    }
    
    func downloadDataFromNetToJson(container: NSManagedObjectContext) {
        // Clean up all local caches
        AsyncData.removeAllLocalFiles()
        
        // Descargar los datos desde internet
        let urlJSONFile = URL(string: "http://madrid-shops.com/json_new/getShops.php")
        URLSession.shared.dataTask(with: urlJSONFile!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else {
                fatalError("Unable to read json file!")
            }
            
            do {
                let d: NSDictionary = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments) as! NSDictionary
                
                var shops = [Shop]()
                if d.allKeys.count > 0 {
                    let arrayData = d.value(forKey: "result") as! NSArray
                    for arrayElement in arrayData{
                        let dict = arrayElement as! NSDictionary
                        print("imprimiendo elemento: " + (dict.value(forKey: "name") as! String))
                    
                        let sh = try decode(data: dict)
                        shops.append(sh)
                    }
                }
                
                // Create the model
                self.loadDataIntoModelCoreData(dataList: shops, context: container)
            } catch let error as NSError {
                print(error)
            }
        }).resume()
    }

    
    private func loadDataIntoModelCoreData(dataList: [Shop], context: NSManagedObjectContext){
        
        for shop in dataList{
            let uniqueObj = CoreShop.uniqueObjectWithValue(name: shop.name, context: context)
            
            // llenar bd shop
            if (uniqueObj == nil) {
                let cShop = CoreShop(context: context)
                cShop.name = shop.name
                cShop.address = shop.address
                cShop.description_en = shop.description_en
                cShop.description_es = shop.description_es
                cShop.gps_lat = shop.gps_lat
                cShop.gps_lon = shop.gps_lon
                cShop.url = shop.url
                cShop.img = shop.img
                cShop.logo_img = shop.logo_img
                
                cShop.imgFileHash = shop.imgFileHash
                cShop.logoFileHash = shop.logoFileHash
                cShop.mapImageHash = shop.mapImageHash
                
                cShop.mapImageUrl = shop.mapImageUrl
                
                saveContext(context: context)
                //print("Insertando objeto CoreShop: %@", cShop )
            }
        }
        
        saveContext(context: context)
        
        DispatchQueue.main.async {
            UserDefaults.standard.set(true, forKey: "loadDataFromInternet")
            // inyectar contexto al siguiente controlador
            self.injectContextToFirstViewController()
        }
    }

}

