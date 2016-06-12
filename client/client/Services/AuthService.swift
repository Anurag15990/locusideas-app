//
//  AuthService.swift
//  client
//
//  Created by Anurag Agnihotri on 5/30/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation
import Alamofire

class AuthService: NSObject {
    
    /**
     Method to login via Facebook
     
     - parameter requestBody:     Facebook Auth Request body.
     - parameter successCallback: Returns a valid auth token.
     - parameter errorCallback:   Returns an NSError object on failure.
     */
    func loginWithFacebook(
        requestBody: FacebookAuthRequestBody,
        successCallback: ((token: String) -> Void),
        errorCallback: ((error: NSError) -> Void)) {
        
        Alamofire.request(
            BaseRouter.AuthRouterManager(AuthRouter.FacebookAuth(requestBody)))
            .debugLog()
            .responseJSON { (response) in
                
                switch response.result {
                case .Success(let value):
                    if let token = value["token"] as? String {
                        successCallback(token: token)
                    }
                case .Failure(let error):
                    errorCallback(error: error)
                }
        }
    }
    
    /**
     Method to login via Email & Password.
     
     - parameter requestBody:     EmailSignInRequestBody Object.
     - parameter successCallback: Returns token string if login successfull.
     - parameter errorCallback:   Returns Error Object if login fails.
     */
    func loginWithEmail(
        requestBody: EmailSignInAuthRequestBody,
        successCallback: ((token: String) -> Void),
        errorCallback: ((error: NSError) -> Void)) {
        
        Alamofire.request(BaseRouter.AuthRouterManager(AuthRouter.EmailSignIn(requestBody)))
        .debugLog()
        .responseJSON { (response) in
            switch response.result {
            case .Success(let value):
                if let token = value["token"] as? String {
                    successCallback(token: token)
                }
            case .Failure(let error):
                errorCallback(error: error)
            }
        }
    }
    
    
    /**
     Method to register via Email
     
     - parameter requestBody:     EmailSignUpRequestBody object.
     - parameter successCallback: Returns token string if login successfull.
     - parameter errorCallback:   Returns Error Object if login fails.
     */
    func registerWithEmail(
        requestBody: EmailSignUpAuthRequestBody,
        successCallback: ((token: String) -> Void),
        errorCallback: ((error: NSError) -> Void)) {
        
        Alamofire.request(BaseRouter.AuthRouterManager(AuthRouter.EmailSignUp(requestBody)))
            .debugLog()
            .responseJSON { (response) in
                switch response.result {
                case .Success(let value):
                    if let token = value["token"] as? String {
                        successCallback(token: token)
                    }
                case .Failure(let error):
                    errorCallback(error: error)
                }
        }
    }
}