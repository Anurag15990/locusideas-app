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
    var name: UserName?
    var emailPrimary: Email?
    var location: UserLocation?
    var picture: Media?
    var cover: Media?
    var createdAt: String?
    var updatedAt: String?
    var profile: DesignerProfile?
    var links: Links?
    var offices: OfficeCollection?
    var contact: Contact?
   
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
        name            <- map["name"]
        emailPrimary    <- map["emailPrimary"]
        location        <- map["location"]
        picture         <- map["picture"]
        cover           <- map["cover"]
        profile         <- map["profile"]
        links           <- map["links"]
        contact         <- map["contact"]
        offices         <- map["offices"]
        createdAt       <- map["createdAt"]
        updatedAt       <- map["updatedAt"]
    }
    
    
    class UserName: BaseRequestBody {
        
        var firstName: String?
        var lastName: String?
        
        override init() {
            super.init()
        }
        
        required init?(_ map: Map) {
            super.init(map)
        }
        
        override func mapping(map: Map) {
            firstName   <- map["firstName"]
            lastName    <- map["lastName"]
        }
    }
    
    class Email: BaseRequestBody {
        
        var address: String?
        var isVerified: Bool?
        
        override init() {
            super.init()
        }
        
        required init?(_ map: Map) {
            super.init(map)
        }
        
        override func mapping(map: Map) {
            address     <- map["address"]
            isVerified  <- map["isVerified"]
        }
    }
    
    class UserLocation: BaseRequestBody {
        
        var currentCity: String?
        
        override init() {
            super.init()
        }
        
        required init?(_ map: Map) {
            super.init(map)
        }
        
        override func mapping(map: Map) {
            currentCity    <- map["currentCity"]
        }
    }
    
    class Description: NSObject, Mappable {
        
        var short: String?
        var complete: String?
        
        override init() {
            super.init()
        }
        
        required init?(_ map: Map) {
            
        }
        
        func mapping(map: Map) {
            short       <- map["short"]
            complete    <- map["complete"]
        }
    }
    
    class Links: NSObject, Mappable {
        
        var primary: String?
        var social: [LinkType]?
        var articles: [LinkType]?
        var others: [LinkType]?
        
        override init() {
            super.init()
        }
        
        required init?(_ map: Map) {
            
        }
        
        func mapping(map: Map) {
            primary     <- map["primary"]
            social      <- map["social"]
            articles    <- map["articles"]
            others      <- map["others"]
        }
        
        /// Type of Links
        class LinkType: NSObject, Mappable {
            
            var type: String?
            var title: String?
            var url: String?
            
            override init() {
                super.init()
            }
            
            required init?(_ map: Map) {
                
            }
            
            func mapping(map: Map) {
                type    <- map["type"]
                title   <- map["title"]
                url     <- map["url"]
            }
        }
    }
    
    class OfficeCollection: NSObject, Mappable {
        var headquarter: Office?
        var others: [Office]?
        
        override init() {
            super.init()
        }
        
        required init?(_ map: Map) {
            
        }
        
        func mapping(map: Map) {
            headquarter     <- map["headquarter"]
            others          <- map["others"]
        }
    }
    
    class Contact: NSObject, Mappable {
        var phone: PhoneCollection?
        
        override init() {
            phone = PhoneCollection()
            super.init()
        }
        
        required init?(_ map: Map) {
            phone = PhoneCollection(map)!
        }
        
        func mapping(map: Map) {
            phone   <- map["phone"]
        }
        
        class PhoneCollection: NSObject, Mappable {
            
            var primary: Phone?
            var others: [Phone]?
            
            override init() {
                super.init()
            }
            
            required init?(_ map: Map) {
                
            }
            
            func mapping(map: Map) {
                primary     <- map["primary"]
                others      <- map["others"]
            }
        }
    }
    
    class DesignerProfile: NSObject, Mappable {
        
        var designer: DesignerObject?
        
        override init() {
            super.init()
        }
        
        required init?(_ map: Map) {
            
        }
        
        func mapping(map: Map) {
            designer    <- map["designer"]
        }
        
        class DesignerObject: NSObject, Mappable {
            
            var specialization: String?
            var skills: [Skill]?
            
            override init() {
                super.init()
            }
            
            required init?(_ map: Map) {
                
            }
            
            func mapping(map: Map) {
                specialization  <- map["specialization"]
                skills <- map["skills"]
            }
            
            class Skill: NSObject, Mappable {
                
                var id: String?
                var title: String?
                
                override init() {
                    super.init()
                }
                
                required init?(_ map: Map) {
                    
                }
                
                func mapping(map: Map) {
                    
                    id <- map["id"]
                    title   <- map["title"]
                }
            }
        }
    }
}