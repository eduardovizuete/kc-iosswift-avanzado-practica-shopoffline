//
//  Shops.swift
//  ShopsOnlinePractica
//
//  Created by usuario on 5/11/17.
//  Copyright © 2017 evizcloud. All rights reserved.
//

import Foundation

class Shop {
    
    //MARK: - StoredProperties
    var name            : String
    var address         : String
    var description_en  : String
    var description_es  : String
    var gps_lat         : String
    var gps_lon         : String
    var url             : String
    var img             : String
    var logo_img        : String
    let _image          : AsyncData
    let _logo           : AsyncData
    let _mapImage       : AsyncData
    
    let imgFileHash     : String
    let logoFileHash    : String
    let mapImageHash    : String
    
    //MARK: - Initialization
    init(   name: String,
            address: String,
            description_en: String,
            description_es: String,
            gps_lat: String,
            gps_lon: String,
            url: String,
            img: String,
            logo_img: String,
            _image: AsyncData,
            _logo: AsyncData,
            _mapImage: AsyncData,
            imgFileHash: String,
            logoFileHash: String,
            mapImageHash: String
        )
    {
        self.name = name
        self.address = address
        self.description_en = description_en
        self.description_es = description_es
        self.gps_lat = gps_lat
        self.gps_lon = gps_lon
        self.url = url
        self.img = img
        self.logo_img = logo_img
        self._image = _image
        self._logo = _logo
        self._mapImage = _mapImage
        
        self.imgFileHash = imgFileHash
        self.logoFileHash = logoFileHash
        self.mapImageHash = mapImageHash
        
        // Set delegate
        self._image.delegate = self
        self._logo.delegate = self
        self._mapImage.delegate = self
    }
    
    //MARK: - Proxies
    func proxieForEquality() -> String {
        return "\(name)"
    }
    
    func proxyForComparison() -> String {
        return proxieForEquality()
    }
}

//MARK: - Protocols
extension Shop: Equatable {
    public static func ==(lhs: Shop, rhs: Shop) -> Bool {
        return (lhs.proxieForEquality() == rhs.proxieForEquality())
    }
}

extension Shop : Comparable {
    public static func <(lhs: Shop, rhs: Shop) -> Bool {
        return (lhs.proxyForComparison() < rhs.proxyForComparison())
    }
}

//MARK: - AsyncDataDelegate
extension Shop: AsyncDataDelegate{
    
    func asyncData(_ sender: AsyncData, didEndLoadingFrom url: URL) {
        print("Finish with \(url)")        
    }
    
    func asyncData(_ sender: AsyncData, shouldStartLoadingFrom url: URL) -> Bool {
        return true
    }
    
    func asyncData(_ sender: AsyncData, willStartLoadingFrom url: URL) {
        print("Starting with \(url)")
    }
    
    func asyncData(_ sender: AsyncData, didFailLoadingFrom url: URL, error: NSError){
        print("Error loading \(url).\n \(error)")
    }
}


