//
//  AuthRouter.swift
//  client
//
//  Created by Anurag Agnihotri on 1/23/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation
import Alamofire

enum AuthRouter: BaseRouterProtocol {
    
    case EmailSignIn(EmailAuthRequestBody)
    
    var path: String {
        
        switch self {
     
        case .EmailSignIn:
            return ""
        
        }
    }
    
    var method: Alamofire.Method {
        
        switch self {
         
        case .EmailSignIn:
            return .POST
        }
    }
    
    
    var parameters: AnyObject? {
        
        switch self {
            
        case .EmailSignIn:
            return nil
        }
    }
    
    var body: BaseRequestBody? {
        
        switch self {
            
        case .EmailSignIn(let requestBody):
            return requestBody
        }
    }
}