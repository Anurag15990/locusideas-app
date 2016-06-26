//
//  UserProfile.swift
//  client
//
//  Created by Anurag Agnihotri on 1/23/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation
import ObjectMapper

/// User Profile Object
class User: BaseRequestBody {
    
    var id: String?
    var firstName: String?
    var lastName: String?
    var email: String?
    var type: String?
    var password: String?
    var facebook: String?
    var twitter: String?
    var status: String?
    var createdAt: NSDate?
    var updatedAt: NSDate?
    
    //TODO: Handle Location for the user.
    
    override init() {
        super.init()
    }
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    /**
     Function used for retrieving data from JSON/ObjectMapper Object and populate the variables. Should be implemented in every Model.
     
     - parameter map: <#map description#>
     */
    override func mapping(map: Map) {
        id              <- map["id"]
        firstName       <- map["firstName"]
        lastName        <- map["lastName"]
        email           <- map["email"]
        type            <- map["type"]
        password        <- map["password"]
        facebook        <- map["facebook"]
        twitter         <- map["twitter"]
        status          <- map["status"]
        createdAt       <- map["createdAt"]
        updatedAt       <- map["updatedAt"]
    }
}