//
//  Designer.swift
//  client
//
//  Created by Anurag Agnihotri on 3/20/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation
import ObjectMapper


/// Model for Designers
class Designer: NSObject, Mappable {
    
    var designerDescription: Description
    var links: Links
    var offices: OfficeCollection
    var contact: Contact
    var approvalStatus: String?
    var createdAt: String?
    var updatedAt: String?
    var createdBy: String?
    var updatedBy: String?
    
    override init() {
        designerDescription = Description()
        links = Links()
        offices = OfficeCollection()
        contact = Contact()
        super.init()
    }
    
    required init?(_ map: Map) {
        designerDescription = Description(map)!
        links = Links(map)!
        offices = OfficeCollection(map)!
        contact = Contact(map)!
    }
    
    func mapping(map: Map) {
        designerDescription     <- map["description"]
        links                   <- map["links"]
        offices                 <- map["offices"]
        contact                 <- map["contact"]
        approvalStatus          <- map["status"]
        createdAt               <- map["createdAt"]
        updatedAt               <- map["updatedAt"]
        createdBy               <- map["createdBy"]
        updatedBy               <- map["updatedBy"]
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
    
    /// Model for Social Links
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
    
    /// Model for list of offices for a particular designer.
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
    
    /// Model for Designer Contact
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
}