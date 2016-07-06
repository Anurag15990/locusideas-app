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
    
    var paging: Pagination?
    
    var errorObservable = Observable<String>("")
    var progressObservable = Observable<ProgressIndicator>(.None)
    
    override init() {
        super.init()
        self.fetchUsers()
    }
    
    /**
     Method to fetch Users from the API.
     */
    func fetchUsers() {
        progressObservable.next(.InProgress)
        UserService.sharedInstance.getDesigners({ (users, paging) in
            self.paging = paging
            self.designersObservableArray.removeAll()
            self.designersObservableArray.appendContentsOf(users)
            self.progressObservable.next(.Finished)
            }) { (error) in
                self.errorObservable.value = error.localizedDescription
                self.progressObservable.next(.Finished)
        }
    }
    
    /**
     Method to fetch Next Set of Users.
     */
    func fetchNextSetOfUsers() {
        if let nextURL = paging?.next {
            progressObservable.next(.InProgress)
            UserService.sharedInstance.getDesignersByURL(nextURL, successCallback: { (users, paging) in
                self.paging = paging
                self.designersObservableArray.appendContentsOf(users)
                self.progressObservable.next(.Finished)
            }) { (error) in
                self.errorObservable.value = error.localizedDescription
                self.progressObservable.next(.Finished)
            }
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