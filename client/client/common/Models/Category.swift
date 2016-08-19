//
//  Category.swift
//  client
//
//  Created by Anurag Agnihotri on 20/08/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation
import ObjectMapper

class CategoriesResponse: NSObject, Mappable {
    
    var categories: [Category]?
    
    override init() {
        super.init()
    }
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        categories  <- map["categories"]
    }

}

class Category: NSObject, Mappable {
    
    var id: String?
    var name: String?
    var categoryDescription: String?
    
    override init() {
        super.init()
    }
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        id                  <- map["id"]
        name                <- map["name"]
        categoryDescription <- map["description"]
    }
    
}