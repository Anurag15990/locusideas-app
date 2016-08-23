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
}