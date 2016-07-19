//
//  DesignerProfileViewModel.swift
//  client
//
//  Created by Anurag Agnihotri on 6/30/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation
import UIKit

class DesignerProfileViewModel: NSObject {
    
    var user: User!
    
    init(user: User) {
        super.init()
        self.user = user
    }
    
    /**
     Method to return User Profile Picture Url
     
     - parameter user: <#user description#>
     
     - returns: <#return value description#>
     */
    func fetchUserProfilePictureUrl() -> String? {
        return user.picture?.url
    }
    
    /**
     Method to return User Cover Image Url
     
     - parameter user: <#user description#>
     
     - returns: <#return value description#>
     */
    func fetchUserCoverImageUrl() -> String? {
        return user.cover?.url
    }
    
    /**
     Method to fetch User Name
     
     - returns: <#return value description#>
     */
    func fetchUserName() -> String {
        var fullName = ""
        
        if let firstName = user.name?.firstName {
            fullName += firstName + " "
        }
        
        if let lastName = user.name?.lastName {
            fullName += lastName + " "
        }
        
        return fullName
    }
    
    func fetchUserLocation() -> String? {
        return user.location?.currentCity
    }
    
    /**
     Method to fetch Location Text for label.
     
     - parameter location: <#location description#>
     
     - returns: <#return value description#>
     */
    func fetchLocationText() -> NSAttributedString? {
        
        let locationIcon = ""
        
        let locationParagraphStyle = NSMutableParagraphStyle()
        
        locationParagraphStyle.lineHeightMultiple = 1.0
        
        if let location = self.fetchUserLocation() {
            
            let locationLabelText = locationIcon + location
            
            let myMutableString = NSMutableAttributedString(string: locationLabelText, attributes: [NSFontAttributeName: UIFont(name: "Asap-Regular", size: 16.0)!])
            
            myMutableString.addAttribute(NSFontAttributeName, value: UIFont(name: "MaterialDesignIcons", size: 16.0)!, range: NSRange(location: 0, length: 1))
            
            myMutableString.addAttribute(NSParagraphStyleAttributeName, value: locationParagraphStyle, range: NSRange(location: 0, length: myMutableString.length))
            
            return myMutableString
        }
        
        return nil
    }
    
    /**
     Method to Construct Follow Button Text.
     
     - returns: <#return value description#>
     */
    func constructFollowButtonText() -> NSAttributedString? {
        
        let followIcon = ""
        
        let followText = followIcon + " Follow"
        
        let attributedString = NSMutableAttributedString(string: followText, attributes: [NSFontAttributeName: UIFont(name: "Asap-Medium", size: 16.0)!])
        
        attributedString.addAttribute(NSFontAttributeName, value: UIFont(name: "MaterialDesignIcons", size: 16.0)!, range: NSRange(location: 0, length: 1))
        
        return attributedString
    }
    
    /**
     Fetch Location Label Height Constant.
     
     - returns: <#return value description#>
     */
    func fetchLocationLabelHeight() -> CGFloat {
        
        if let _ = self.fetchLocationText() {
            return 21
        }

        return 0
    }
    
    func fetchLocationLabelPadding() -> CGFloat {
        if let _ = self.fetchLocationText() {
            return 8
        }
        
        return 0
    }
    
}