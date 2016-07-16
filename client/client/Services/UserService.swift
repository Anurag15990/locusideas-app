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
    
    static let sharedInstance = UserService()
    
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
            let userMeResponse =  Mapper<UserMeResponse>().map(userString)
            return userMeResponse?.user
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
                if let user = Mapper<User>().map(value) {
                    successCallback(user: user)
                }
                
            case .Failure(let error):
                errorCallback(error: error)
            }
        }
    }
    
    /**
     Method to Fetch All Users.
     
     - parameter successCallback: Returns an Array of Users
     - parameter errorCallback:   Returns an Error if Request Fails.
     */
    func getUsers(successCallback: ((users: [User]) -> Void),
                  errorCallback: ((error: NSError) -> Void)) {
        
        Alamofire.request(BaseRouter.UserRouteManager(UserRouter.GetUsers()))
        .debugLog()
        .responseString { (response) in
            switch response.result {
            case .Success(let value):
                let userResponse = Mapper<UserResponse>().map(value)
                if let users = userResponse?.users {
                    successCallback(users: users)
                }
            case .Failure(let error):
                errorCallback(error: error)
            }
        }
    }
    
    /**
     Method to Fetch All Users.
     
     - parameter successCallback: Returns an Array of Users
     - parameter errorCallback:   Returns an Error if Request Fails.
     */
    func getDesigners(successCallback: ((users: [User], pagination: Pagination?) -> Void),
                  errorCallback: ((error: NSError) -> Void)) {
        
        Alamofire.request(BaseRouter.UserRouteManager(UserRouter.GetDesigners()))
            .debugLog()
            .responseString { (response) in
                switch response.result {
                case .Success(let value):
                    let userResponse = Mapper<UserResponse>().map(value)
                    if let users = userResponse?.userDesigners {
                        successCallback(users: users, pagination: userResponse?.paging)
                    }
                case .Failure(let error):
                    errorCallback(error: error)
                }
        }
    }
    
    /**
     Method to fetch designers by URL. 
     
     - parameter url:             <#url description#>
     - parameter successCallback: <#successCallback description#>
     - parameter errorCallback:   <#errorCallback description#>
     */
    func getDesignersByURL(url: String,
                           successCallback: ((users: [User], pagination: Pagination?) -> Void),
                           errorCallback: ((error: NSError) -> Void)) {
        
        Alamofire.request(BaseRouter.UserRouteManager(UserRouter.GetDesignersByURL(url)))
        .debugLog()
        .responseString { (response) in
            switch response.result {
            case .Success(let value):
                let userResponse = Mapper<UserResponse>().map(value)
                if let users = userResponse?.userDesigners {
                    successCallback(users: users, pagination: userResponse?.paging)
                }
            case .Failure(let error):
                errorCallback(error: error)
            }
        }
    }
}