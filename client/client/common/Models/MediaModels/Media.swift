//
//  Media.swift
//  client
//
//  Created by Anurag Agnihotri on 6/24/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation
import ObjectMapper

class Media: NSObject, Mappable {
    
    var id: String?
    var type: String?
    var title: String?
    var cloudinaryId: String?
    var url: String?
    var width: Int?
    var height: Int?
    
    override init() {
        super.init()
    }
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        id      <- map["id"]
        type    <- map["type"]
        title   <- map["title"]
        cloudinaryId    <- map["cloudinaryId"]
        url             <- map["url"]
        width           <- map["width"]
        height          <- map["height"]
    
    }
}