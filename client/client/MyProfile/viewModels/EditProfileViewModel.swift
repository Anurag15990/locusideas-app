//
//  EditProfileViewModel.swift
//  client
//
//  Created by Anurag Agnihotri on 25/08/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation

class EditProfileViewModel: NSObject {
    
    var user: User!
    
    override init() {
        self.user = UserService.getUser()
        super.init()
    }
    
    func fetchFirstName() -> String? {
        return self.user.name?.firstName
    }
    
    func fetchLastName() -> String? {
        return self.user.name?.lastName
    }
    
    func fetchPhoneNumber() -> String? {
        return self.user.phonePrimary?.subscriberNumber
    }
    
    func fetchProfilePictureUrl() -> String? {
        return self.user.picture?.url
    }
}