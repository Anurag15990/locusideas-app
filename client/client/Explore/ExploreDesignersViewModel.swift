//
//  ExploreDesignersViewModel.swift
//  client
//
//  Created by Anurag Agnihotri on 6/27/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation
import Bond

class ExploreDesignersViewModel: NSObject {
    
    var designersObservableArray = ObservableArray<User>()
    
    var errorObservable = Observable<String>("")
    
    override init() {
        super.init()
        self.fetchUsers()
    }
    
    /**
     Method to fetch Users from the API.
     */
    func fetchUsers() {
        
        UserService.sharedInstance.getUsers({ (users) in
            self.designersObservableArray.removeAll()
            self.designersObservableArray.appendContentsOf(users)
            }) { (error) in
                self.errorObservable.value = error.localizedDescription
        }
    }
    
    /**
     Method to return User Profile Picture Url
     
     - parameter user: <#user description#>
     
     - returns: <#return value description#>
     */
    func fetchUserProfilePictureUrl(user: User) -> String? {
        return user.picture?.url
    }
    
    /**
     Method to return User Cover Image Url
     
     - parameter user: <#user description#>
     
     - returns: <#return value description#>
     */
    func fetchUserCoverImageUrl(user: User) -> String? {
        return user.cover?.url
    }
    
    /**
     Method to fetch User Name.
     
     - parameter user: <#project description#>
     
     - returns: <#return value description#>
     */
    func fetchUserName(user: User) -> String {
        
        var fullName = ""
        
        if let firstName = user.name?.firstName {
            fullName += firstName + " "
        }
        
        if let lastName = user.name?.lastName {
            fullName += lastName + " "
        }
        
        return fullName
    }
}