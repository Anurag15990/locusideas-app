//
//  MediaObject.swift
//  client
//
//  Created by Anurag Agnihotri on 6/24/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation
import ObjectMapper

class MediaObject: NSObject, Mappable {
 
    var count: String?
    var initial: [InitialMedia]?
    
    override init() {
        super.init()
    }
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        count   <- map["count"]
        initial <- map["initial"]
    
    }
    
    class InitialMedia: NSObject, Mappable {
        
        var media: Media?
        var position: Int?
        
        override init() {
            super.init()
        }
        
        required init?(_ map: Map) {
            
        }
        
        func mapping(map: Map) {
            
            media   <- map["media"]
            position    <- map["position"]
        
        }
    }
}