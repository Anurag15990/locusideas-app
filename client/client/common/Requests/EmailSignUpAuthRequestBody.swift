//
//  EmailSignUpAuthRequestBody.swift
//  client
//
//  Created by Anurag Agnihotri on 1/23/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation
import ObjectMapper

/// This class is the Request Body to be passed while the user signs up through EmailId and Password.
class EmailSignUpAuthRequestBody: BaseRequestBody {
    
    var firstName: String?
    var lastName: String?
    var emailId: String?
    var password: String?
    var confirmPassword: String?
    
    override init() {
        super.init()
    }
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        
        firstName       <- map["firstName"]
        lastName        <- map["lastName"]
        emailId         <- map["emailId"]
        password        <- map["password"]
        confirmPassword <- map["confirmPassword"]
        
    }
}