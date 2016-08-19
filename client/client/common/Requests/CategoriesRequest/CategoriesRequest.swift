//
//  CategoriesRequest.swift
//  client
//
//  Created by Anurag Agnihotri on 19/08/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class CategoriesRequest: BaseRequestBody {
    
    var name: String?
    var categoryDescription: String?
    
    override init() {
        super.init()
    }
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        
        name       <- map["name"]
        categoryDescription <- map["description"]
        
    }
}