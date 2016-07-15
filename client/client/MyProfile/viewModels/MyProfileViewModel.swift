//
//  MyProfileViewModel.swift
//  client
//
//  Created by Anurag Agnihotri on 15/07/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation
import UIKit

class MyProfileViewModel: NSObject {
    
    var user: User!
    
    override init() {
        super.init()
        self.user = UserService.getUser()
    }
    
    /**
     Method to return User Profile Picture Url
     
     - parameter user: <#user description#>
     
     - returns: <#return value description#>
     */
    func fetchUserProfilePictureUrl() -> String? {
        return self.user.picture?.url
    }
    
    /**
     Method to return User Cover Image Url
     
     - parameter user: <#user description#>
     
     - returns: <#return value description#>
     */
    func fetchUserCoverImageUrl() -> String? {
        return self.user.cover?.url
    }
    
    /**
     Method to fetch User Name.
     
     - parameter user: <#project description#>
     
     - returns: <#return value description#>
     */
    func fetchUserName() -> String {
        
        var fullName = ""
        
        if let firstName = self.user.name?.firstName {
            fullName += firstName + " "
        }
        
        if let lastName = self.user.name?.lastName {
            fullName += lastName + " "
        }
        
        return fullName
    }
    
    /**
     Method to fetch User Location
     
     - returns: <#return value description#>
     */
    func fetchUserLocation() -> NSAttributedString? {
        
        if let location = user.location?.currentCity {
            
            let locationText = ""
            
            let attributedText = NSMutableAttributedString(string: "\(locationText) \(location)", attributes: [NSFontAttributeName:UIFont(name: "Asap-Medium", size: 16.0)!])
            
            attributedText.addAttribute(NSFontAttributeName, value: UIFont(name: "MaterialDesignIcons", size: 16.0)!, range: NSRange(location: 0, length: 1))
            
            return attributedText
        }
        
        return nil
    }

    /**
     Method to fetch User Email.
     
     - returns: <#return value description#>
     */
    func fetchUserEmail() -> NSAttributedString? {
        
        if let email = user.emailPrimary?.address {
            
            let emailText = ""
            
            let attributedText = NSMutableAttributedString(string: "\(emailText)  \(email)", attributes: [NSFontAttributeName:UIFont(name: "Asap-Medium", size: 14.0)!])
            
            attributedText.addAttribute(NSFontAttributeName, value: UIFont(name: "MaterialDesignIcons", size: 15.0)!, range: NSRange(location: 0, length: 1))
            
            return attributedText
        }
        
        return nil
    }
}