//
//  Project.swift
//  client
//
//  Created by Anurag Agnihotri on 6/24/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation
import ObjectMapper

class Project: BaseRequestBody {
    
    var id: String?
    var title: String?
    var createdAt: String?
    var updatedAt: String?
    var medias: MediaObject?
    
    override init() {
        super.init()
    }
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        id          <- map["id"]
        title       <- map["title"]
        createdAt   <- map["createdAt"]
        updatedAt   <- map["updatedAt"]
        medias      <- map["medias"]
    }
}