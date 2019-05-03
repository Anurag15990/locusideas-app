//
//  UserMeResponse.swift
//  client
//
//  Created by Anurag Agnihotri on 16/07/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation
import ObjectMapper

class UserMeResponse: NSObject, Mappable {
    
    var user: User?
    
    override init() {
        super.init()
    }
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        user  <- map["user"]
    }
}