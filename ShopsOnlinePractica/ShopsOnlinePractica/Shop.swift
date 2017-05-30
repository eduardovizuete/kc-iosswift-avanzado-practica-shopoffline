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
    
    //MARK: - Initialization
    init(   name: String,
            address: String,
            description_en: String,
            description_es: String,
            gps_lat: String,
            gps_lon: String,
            url: String,
            img: String,
            logo_img: String)
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

