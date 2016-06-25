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
    var projectDescription: String?
    var createdAt: String?
    var updatedAt: String?
    var medias: MediaObject?
    var owner: OwnerObject?
    
    override init() {
        super.init()
    }
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        id          <- map["id"]
        title       <- map["title"]
        projectDescription <- map["description"]
        createdAt   <- map["createdAt"]
        updatedAt   <- map["updatedAt"]
        medias      <- map["medias"]
        owner       <- map["owner"]
    }
    
    class OwnerObject: BaseRequestBody {
        
        var user : UserObject?
        
        override init() {
            super.init()
        }
        
        required init?(_ map: Map) {
            super.init()
        }
        
        override func mapping(map: Map) {
            user    <- map["user"]
        }

        
        class UserObject : BaseRequestBody {
            
            var name : OwnerName?
            var picture : Media?
            
            override init() {
                super.init()
            }
            
            required init?(_ map: Map) {
                super.init()
            }
            
            override func mapping(map: Map) {
                name    <- map["name"]
                picture <- map["picture"]
            }
        }
    }
    
    class OwnerName: BaseRequestBody {
        
        var firstName : String?
        var lastName : String?
        
        override init() {
            super.init()
        }
        
        required init?(_ map: Map) {
            super.init()
        }
        
        override func mapping(map: Map) {
            firstName   <- map["firstName"]
            lastName    <- map["lastName"]
        }
        
    }
}