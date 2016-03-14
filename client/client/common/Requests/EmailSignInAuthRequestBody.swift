//
//  EmailAuthRequestBody.swift
//  client
//
//  Created by Anurag Agnihotri on 1/23/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation
import ObjectMapper

/// This class is the Request Body to be passed while the user logs in through EmailId and Password.
class EmailSignInAuthRequestBody: BaseRequestBody {
    
    var emailId: String?
    var password: String?
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override init() {
        super.init()
    }
    
    override func mapping(map: Map) {
        emailId     <- map["emailId"]
        password    <- map["password"]
    }
}

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