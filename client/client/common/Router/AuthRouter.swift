//
//  AuthRouter.swift
//  client
//
//  Created by Anurag Agnihotri on 1/23/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation
import Alamofire

/**
 This Enum is used for handling all the Auth Parameters.
 
 - EmailSignIn: This case is when the user is signing in using EmailId and Password
 */
enum AuthRouter: BaseRouterProtocol {
    
    case EmailSignIn(EmailSignInAuthRequestBody)
    
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