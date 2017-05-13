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
    let name            : String
    let address         : String
    let description_en  : String
    let description_es  : String
    let gps_lat         : String
    let gps_lon         : String
    
    //MARK: - Initialization
    init(   name: String,
            address: String,
            description_en: String,
            description_es: String,
            gps_lat: String,
            gps_lon: String)
    {
        self.name = name
        self.address = address
        self.description_en = description_en
        self.description_es = description_es
        self.gps_lat = gps_lat
        self.gps_lon = gps_lon
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

