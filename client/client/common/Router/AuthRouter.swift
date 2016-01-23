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
    case EmailSignUp(EmailSignUpAuthRequestBody)
    
    var path: String {
        
        switch self {
     
        case .EmailSignIn:
            return ""
            
        case .EmailSignUp:
            return ""
        
        }
    }
    
    var method: Alamofire.Method {
        
        switch self {
         
        case .EmailSignIn:
            return .POST
            
        case .EmailSignUp:
            return .POST
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
            
        case .EmailSignIn(let requestBody):
            return requestBody
            
        case .EmailSignUp(let requestBody):
            return requestBody
        }
    }
}