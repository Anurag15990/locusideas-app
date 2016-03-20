//
//  UserRouter.swift
//  client
//
//  Created by Anurag Agnihotri on 3/20/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation
import Alamofire

enum UserRouter: BaseRouterProtocol {
 
    case GetMeRequest()
    
    var path: String {
        
        switch self {
        
        case .GetMeRequest():
            return "/api/users/me"
        
        }
    
    }
    
    var method: Alamofire.Method {
    
        switch self {
        
        case .GetMeRequest:
            return .GET
        }
    
    }
    
    var parameters: AnyObject? {
        
        switch self {
        
        default:
            return nil
        
        }
    
    }
    
    var body: BaseRequestBody? {
        switch self {
        
        default:
            return BaseRequestBody()
        }
    }
}