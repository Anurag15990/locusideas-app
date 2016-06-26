//
//  NSUserDefaults.swift
//  client
//
//  Created by Anurag Agnihotri on 1/23/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation

public struct NSUserDefaultsUtils {
    
    public static let userAuthToken = "userAuthToken"
    
    public static let userAnonymousToken = "userAnonymousToken"
    
    public static let userDetails = "userDetails"
    
    /**
     Function sets anonymous token for a user if he is not logged in.
     
     - parameter value: <#value description#>
     */
    public static func setAnonymousToken(value: String) {
        setObject(value, key: userAnonymousToken)
    }
    
    /**
     Retrieves anonymous token for the user.
     
     - returns: <#return value description#>
     */
    public static func getAnonymousToken() -> String? {
        return getObject(userAnonymousToken) as? String
    }
    
    /**
     Stores Auth Token of the user after he logs in.
     
     - parameter value: <#value description#>
     */
    public static func setAuthToken(value: String) {
        setObject(value, key: userAuthToken)
    }
    
    /**
     Retrieves Auth Token for making further requests
     
     - returns: <#return value description#>
     */
    public static func getAuthToken() -> String? {
        return getObject(userAuthToken) as? String
    }
    
    /**
     Stores user information for the currently logged in user.
     
     - parameter value: <#value description#>
     */
    public static func setUserDetails(value: String) {
        setObject(value, key: userDetails)
    }
    
    /**
     Retrieves information of the currently logged in user.
     
     - returns: <#return value description#>
     */
    public static func getUserDetails() -> String? {
        return getObject(userDetails) as? String
    }
    
    /**
     Function for getting the bool value corresponding to a key from NSUserDefaults.
     
     - parameter key: <#key description#>
     
     - returns: <#return value description#>
     */
    public static func getBool(key: String) -> Bool {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        return userDefaults.boolForKey(key)
    }
    
    /**
     Function for setting the bool value for corresponding key in NSUserDefaults.
     
     - parameter value: <#value description#>
     - parameter key:   <#key description#>
     */
    public static func setBool(value: Bool, key: String) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setBool(value, forKey: key)
    }
    
    /**
     Function for setting the Int value for corresponding key in NSUserDefaults.
     
     - parameter value: <#value description#>
     - parameter key:   <#key description#>
     */
    public static func setInt(value: Int, key: String) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setInteger(value, forKey: key)
    }
    
    /**
     Function for getting the Int value for corresponding key in NSUserDefaults.
     
     - parameter key: <#key description#>
     
     - returns: <#return value description#>
     */
    public static func getInt(key: String) -> Int {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        return userDefaults.integerForKey(key)
    }
    
    /**
     Function used to set an object for corresponding key in NSUserDefaults.
     
     - parameter value: <#value description#>
     - parameter key:   <#key description#>
     */
    public static func setObject(value: AnyObject, key: String) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(value, forKey: key)
    }
    
    /**
     Function used to get an object for corresponding key from NSUserDefaults.
     
     - parameter key: <#key description#>
     
     - returns: <#return value description#>
     */
    public static func getObject(key: String) -> AnyObject? {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        return userDefaults.objectForKey(key)
    }
}