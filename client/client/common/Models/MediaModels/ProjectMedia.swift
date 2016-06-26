//
//  ProjectMedia.swift
//  client
//
//  Created by Anurag Agnihotri on 6/26/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation
import ObjectMapper

class ProjectMedia: NSObject, Mappable {
    
    var projectMedias: [MediaObject.InitialMedia]?
    
    override init() {
        super.init()
    }
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        projectMedias   <- map["projectMedias"]
    }
}