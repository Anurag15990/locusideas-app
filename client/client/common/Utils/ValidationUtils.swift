//
//  ValidationUtils.swift
//  client
//
//  Created by Neha Yadav on 26/06/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation
import UIKit

class ValidationUtils {
    
    static func isValidEmail(email:String) -> Bool {

        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(email)
    }
    
    static func isEmptyTextField(textField:UITextField) -> Bool {
        
        if let text = textField.text where text.isEmpty {
            return true
        }
        
        return false
    }
    
}
