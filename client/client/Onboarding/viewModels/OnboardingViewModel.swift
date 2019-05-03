//
//  OnboardingViewModel.swift
//  client
//
//  Created by Anurag Agnihotri on 24/08/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation

class OnboardingViewModel: NSObject {
    
    var onboardingRequestBody: UserOnboardingRequestBody!
    
    override init() {
        super.init()
        self.onboardingRequestBody = UserOnboardingRequestBody()
    }
    
    func setLocationInRequestBody(location: String) {
        self.onboardingRequestBody.preferences!.city = location
    }
    
    func setCategoriesInRequestBody(categories: [String]) {
        self.onboardingRequestBody.preferences!.categories = categories
    }
    
    func setBio(bio: String) {
        self.onboardingRequestBody.bio = bio
    }
    
    func onboardUser(successCallback: (() -> Void),
                     errorCallback: ((error: NSError) -> Void)) {
        
        UserService.sharedInstance.onboardUser(UserService.getUser()!.id!, requestBody: self.onboardingRequestBody, successCallback: { (user) in
            successCallback()
            }) { (error) in
                errorCallback(error: error)
        }
    }
}