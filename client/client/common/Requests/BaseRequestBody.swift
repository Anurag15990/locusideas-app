////
////  RequestBody.swift
////  client
////
////  Created by Anurag Agnihotri on 1/9/16.
////  Copyright © 2016 LocusIdeas. All rights reserved.
////


import Foundation
import ObjectMapper

/*
*   This class must be extended by All the Request body classes.
*/
class BaseRequestBody: NSObject, Mappable {
    
    override init() {
        
    }
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        
    }
}