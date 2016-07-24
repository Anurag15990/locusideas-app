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
    func fetchUserEmail() -> String? {
        return self.user.emailPrimary?.address
    }
    
    /**
     Method to fetch User Primary Contact Number.
     
     - returns: <#return value description#>
     */
    func fetchUserPrimaryContact() -> String? {
        return self.user.phonePrimary?.subscriberNumber
    }
    
    func fetchUserBio() -> String? {
        return self.user.bio?.short
    }
    
    func fetchUserWebsite() -> String? {
        return self.user.links?.website?.primary
    }
    
    func fetchUserSocialLink(index: Int) -> (String, String)? {
        if let social = self.user.links?.social {
            let socialObject = social[index]
            
            switch  socialObject.type! {
            
            case "facebook":
                return ("", socialObject.url!)
            
            case "twitter":
                return ("", socialObject.url!)
                
            case "instagram":
                return ("", socialObject.url!)
                
            case "linkedIn":
                return ("", socialObject.url!)
            
            default:
                return nil
            }
        }
        
        return nil
    }
    
    
    /**
     Method to fetch Number Of Sections For TableView Based on Data.
     
     - returns: <#return value description#>
     */
    func fetchNumberOfRowsForTableView(section: Int) -> Int {
        
        switch  section {
        case 0:
            return 1
            
        case 1:
            
            var initialValue = 0
            
            if let _ = user.emailPrimary?.address {
                initialValue += 1
            }
            
            if let _ = user.phonePrimary?.subscriberNumber {
                initialValue += 1
            }
            
            return initialValue
            
        case 2:
            var initialValue = 0
            
            if let _ = self.user.links?.website {
                initialValue += 1
            }
            
            if let socialLinks = self.user.links?.social {
                initialValue += socialLinks.count
            }
            
            if let articles = self.user.links?.articles {
                initialValue += articles.count
            }
            
            if let others = self.user.links?.others {
                initialValue += others.count
            }
            
            return initialValue
        default:
            return 0
        }
        
    }
}