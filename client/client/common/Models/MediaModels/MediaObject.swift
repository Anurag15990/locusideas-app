//
//  MediaObject.swift
//  client
//
//  Created by Anurag Agnihotri on 6/24/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation
import ObjectMapper

class MediaObject: BaseRequestBody {
 
    var count: String?
    var initial: [InitialMedia]?
    
    override init() {
        super.init()
    }
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        
        count   <- map["count"]
        initial <- map["initial"]
    
    }
    
    class InitialMedia: BaseRequestBody {
        
        var media: Media?
        var position: Int?
        
        override init() {
            super.init()
        }
        
        required init?(_ map: Map) {
            super.init(map)
        }
        
        override func mapping(map: Map) {
            
            media   <- map["media"]
            position    <- map["position"]
        
        }
    }
}