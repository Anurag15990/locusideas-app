//
//  UserService.swift
//  client
//
//  Created by Anurag Agnihotri on 5/31/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class UserService: NSObject {
    
    /**
     Method to get User Details from the API. Stores the user details in NSUserDefaults and returns the Locally Stored Object.
     
     - parameter successCallback: Returns User Object if request is successfull
     - parameter errorCallback:   Returns Error Object.
     */
    func getMeRequest(successCallback: ((user: User) -> Void),
        errorCallback: ((error: NSError) -> Void)) {
        
        Alamofire.request(BaseRouter.UserRouteManager(UserRouter.GetMeRequest()))
        .debugLog()
            .responseString { response in
                switch response.result {
                case .Success(let value):
                    NSUserDefaultsUtils.setUserDetails(value)
                    if let user = UserService.getUser() {
                        successCallback(user: user)
                    }
                    break
                case .Failure(let error):
                    errorCallback(error: error)
                    break
                }
        }
    }
    
    /**
     Fetching User Object from NSUserDefaults i.e. Local Storage.
     
     - returns: User Object.
     */
    static func getUser() -> User?  {
        
        if let userString = NSUserDefaultsUtils.getUserDetails() {
            return Mapper<User>().map(userString)
        }
        
        return nil
    }
    
    
    /**
     Method to Update User Object corresponding to specific User ID.
     
     - parameter userId:          User ID of the user to be updated
     - parameter requestBody:     User Request Body.
     - parameter successCallback: Returns if request is successfull.
     - parameter errorCallback:   Returns if error is encountered.
     */
    func updateUser(userId: String,
                    requestBody: User,
                    successCallback: (() -> Void),
                    errorCallback: ((error: NSError) -> Void)) {
        
        Alamofire.request(BaseRouter.UserRouteManager(UserRouter.UpdateUserRequest(userId, requestBody)))
        .debugLog()
            .responseString { response in
                switch response.result {
                case .Success( _):
                    successCallback()
                case .Failure(let error):
                    errorCallback(error: error)
                }
                
        }
    }
    
    /**
     Method to Fetch A User Object corresponding to a User Id.
     
     - parameter userId:          User Id of the user to fetch
     - parameter successCallback: Returns User Object.
     - parameter errorCallback:   Returns Error Object.
     */
    func getUserById(userId: String,
                     successCallback: ((user: User) -> Void),
                     errorCallback: ((error: NSError) -> Void)) {
        
        Alamofire.request(BaseRouter.UserRouteManager(UserRouter.GetUser(userId)))
        .debugLog()
        .responseString { (response) in
            switch response.result {
            case .Success(let value):
                let user = Mapper<User>().map(value)
                if let user = user {
                    successCallback(user: user)
                }
                
            case .Failure(let error):
                errorCallback(error: error)
            }
        }
    }
}