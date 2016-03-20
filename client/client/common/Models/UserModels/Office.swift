//
//  Office.swift
//  client
//
//  Created by Anurag Agnihotri on 3/20/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation
import ObjectMapper

/// Model for Office Details
class Office: NSObject, Mappable {
    
    var title: String?
    var address: Address
    
    override init() {
        address = Address()
        super.init()
    }
    
    required init?(_ map: Map) {
        address = Address(map)!
    }
    
    func mapping(map: Map) {
        
    }
    
    /// Model for Address. Can be generic later.
    class Address: NSObject, Mappable {
        
        var street: String?
        var locality: String?
        var city: String?
        var state: String?
        var country: String?
        var postalCode: Int?
        
        override init() {
            super.init()
        }
        
        required init?(_ map: Map) {
            
        }
        
        func mapping(map: Map) {
            street      <- map["street"]
            locality    <- map["locality"]
            city        <- map["city"]
            state       <- map["state"]
            country     <- map["country"]
            postalCode  <- map["postalCode"]
        }
    }
}