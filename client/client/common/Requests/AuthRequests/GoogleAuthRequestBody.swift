//
//  GoogleAuthRequestBody.swift
//  client
//
//  Created by Anurag Agnihotri on 23/08/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation
import ObjectMapper

class GoogleAuthRequestBody: BaseRequestBody {
    
    var type: String?
    var accessToken: String?
    var id: String?
    
    required init?(_ map: Map) {
        super.init(map)
        type = "google"
    }
    
    override init() {
        super.init()
        type = "google"
    }
    
    override func mapping(map: Map) {
        type            <- map["type"]
        accessToken     <- map["accessToken"]
        id              <- map["id"]
    }

    
}