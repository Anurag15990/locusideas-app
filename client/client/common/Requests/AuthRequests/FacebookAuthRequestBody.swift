//
//  FacebookAuthRequestBody.swift
//  client
//
//  Created by Anurag Agnihotri on 3/19/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation

class FacebookAuthRequestBody: BaseRequestBody {
    
    var type: String?
    var accessToken: String?
    var id: String?
    
    required init?(_ map: Map) {
        super.init(map)
        type = "facebook"
    }
    
    override init() {
        super.init()
        type = "facebook"
    }
    
    override func mapping(map: Map) {
        type            <- map["type"]
        accessToken     <- map["accessToken"]
        id              <- map["id"]
    }
    
}