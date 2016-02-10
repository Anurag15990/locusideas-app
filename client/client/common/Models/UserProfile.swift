//
//  UserProfile.swift
//  client
//
//  Created by Anurag Agnihotri on 1/23/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

//import Foundation
//import ObjectMapper
//
///// User Profile Object
//class UserProfile: Mappable {
//    
//    var id: String?
//    var firstName: String?
//    var lastName: String?
//    var email: String?
//    var type: String?
//    var approvedStatus: Bool?
//    var password: String?
//    
//    //TODO: Handle Location for the user.
//    
//    required init?(_ map: Map) {
//        
//    }
//    
//    /**
//     Function used for retrieving data from JSON/ObjectMapper Object and populate the variables. Should be implemented in every Model.
//     
//     - parameter map: <#map description#>
//     */
//    func mapping(map: Map) {
//        
//        id              <- map["id"]
//        firstName       <- map["firstName"]
//        lastName        <- map["lastName"]
//        email           <- map["email"]
//        type            <- map["type"]
//        approvedStatus  <- map["approvedStatus"]
//        password        <- map["password"]
//    
//    }
//}