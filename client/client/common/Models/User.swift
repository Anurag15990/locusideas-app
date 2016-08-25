//
//  UserProfile.swift
//  client
//
//  Created by Anurag Agnihotri on 1/23/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation
import ObjectMapper

class Duration: BaseRequestBody {
    
    var from: String?
    var to: String?
    
    override init() {
        super.init()
    }
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        from    <- map["from"]
        to      <- map["to"]
    }
}

/// User Profile Object
class User: BaseRequestBody {
    
    var id: String?
    var name: UserName?
    var bio: Bio?
    var emailPrimary: Email?
    var phonePrimary: Phone?
    var emailOthers: [Email]?
    var phoneOthers: [Phone]?
    var location: UserLocation?
    var picture: Media?
    var cover: Media?
    var createdAt: String?
    var updatedAt: String?
    var onboardedAt: String?
    var links: Links?
    var work: Work?
    var education: Education?
    var offices: OfficeCollection?
    var skills: [Skill]?
    var specialization: String?
   
    //TODO: Handle Location for the user.
    
    override init() {
        self.name = UserName()
        self.phonePrimary = Phone()
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
        bio             <- map["bio"]
        emailPrimary    <- map["emailPrimary"]
        phonePrimary    <- map["phonePrimary"]
        emailOthers     <- map["emailOthers"]
        phoneOthers     <- map["phoneOthers"]
        location        <- map["location"]
        picture         <- map["picture"]
        cover           <- map["cover"]
        links           <- map["links"]
        skills          <- map["skills"]
        specialization  <- map["specialization"]
        work            <- map["work"]
        education       <- map["education"]
        offices         <- map["offices"]
        onboardedAt     <- map["onboardedAt"]
        createdAt       <- map["createdAt"]
        updatedAt       <- map["updatedAt"]
    }
    
    class Work: BaseRequestBody {
        
        var experience: [WorkExperience]?
        
        override init() {
            super.init()
        }
        
        required init?(_ map: Map) {
            super.init(map)
        }
        
        override func mapping(map: Map) {
            experience  <- map["experience"]
        }
        
        class WorkExperience: BaseRequestBody {
            
            var id: String?
            var organization: String?
            var designation: String?
            var duration: Duration?
            
            override init() {
                super.init()
            }
            
            required init?(_ map: Map) {
                super.init(map)
            }
            
            override func mapping(map: Map) {
                
                id              <- map["id"]
                organization    <- map["organization"]
                designation     <- map["designation"]
                duration        <- map["duration"]
            }
        }
    }
    
    class Education: BaseRequestBody {
        
        var experience: [EducationExperience]?
        
        override init() {
            super.init()
        }
        
        required init?(_ map: Map) {
            super.init(map)
        }
        
        override func mapping(map: Map) {
            experience  <- map["experience"]
        }
        
        class EducationExperience: BaseRequestBody {
            
            var id: String?
            var school: String?
            var degree: String?
            var duration: Duration?
            
            override init() {
                super.init()
            }
            
            required init?(_ map: Map) {
                super.init(map)
            }
            
            override func mapping(map: Map) {
                
                id              <- map["id"]
                school    <- map["school"]
                degree     <- map["degree"]
                duration        <- map["duration"]
            }
        }
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
    
    class Bio: BaseRequestBody {
        var short: String?
        
        override init() {
            super.init()
        }
        
        required init?(_ map: Map) {
            super.init(map)
        }
        
        override func mapping(map: Map) {
            short <- map["short"]
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
        
        var website: Website?
        var social: [LinkType]?
        var articles: [LinkType]?
        var others: [LinkType]?
        
        override init() {
            super.init()
        }
        
        required init?(_ map: Map) {
            
        }
        
        func mapping(map: Map) {
            website     <- map["website"]
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
                url     <- map["uri"]
            }
        }
        
        class Website: NSObject, Mappable {
            
            var primary: String?
            
            override init() {
                super.init()
            }
            
            required init?(_ map: Map) {
                
            }
            
            func mapping(map: Map) {
                primary     <- map["primary"]
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
}