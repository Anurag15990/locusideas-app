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
    
    

}