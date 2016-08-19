//
//  UserOnboardingRequestBody.swift
//  client
//
//  Created by Anurag Agnihotri on 19/08/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation
import ObjectMapper

class UserOnboardingRequestBody: BaseRequestBody {
 
    var bio: String?
    var preferences: UserOnboardingPreferences?

    override init() {
        super.init()
    }
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        bio         <- map["bio"]
        preferences <- map["preferences"]
    }
    
    class UserOnboardingPreferences: BaseRequestBody {
        
        var city: String?
        var categories: [String]?
        
        override init() {
            super.init()
        }
        
        required init?(_ map: Map) {
            super.init(map)
        }
        
        override func mapping(map: Map) {
            city        <- map["city"]
            categories  <- map["categories"]
        }
    }
}