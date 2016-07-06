//
//  UserResponse.swift
//  client
//
//  Created by Anurag Agnihotri on 6/29/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation
import ObjectMapper

class UserResponse: NSObject, Mappable {
    
    var users: [User]?
    var userDesigners: [User]?
    var paging: Pagination?
    
    override init() {
        super.init()
    }
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        users <- map["users"]
        userDesigners <- map["userDesigners"]
        paging  <- map["paging"]
    }
}