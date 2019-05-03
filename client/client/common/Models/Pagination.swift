//
//  Pagination.swift
//  client
//
//  Created by Anurag Agnihotri on 7/6/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation
import ObjectMapper

class Pagination: NSObject, Mappable {
    
    var previous: String?
    var next: String?
    var total: Int?
    
    override init() {
        super.init()
    }
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        previous    <- map["previous"]
        next        <- map["next"]
        total       <- map["total"]
    }
}