//
//  Phone.swift
//  client
//
//  Created by Anurag Agnihotri on 3/20/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation
import ObjectMapper

/// Model for Phone Number
class Phone: NSObject, Mappable {
    
    var subscriberNumber: String?
    var countryCode: String?
    var isVerified: Bool?
    
    override init() {
        super.init()
    }
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        subscriberNumber    <- map["subscriberNumber"]
        countryCode         <- map["countryCode"]
        isVerified          <- map["isVerified"]
    }
}
