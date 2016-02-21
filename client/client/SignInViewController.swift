//
//  LoginViewController.swift
//  client
//
//  Created by Neha Yadav on 06/01/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation
import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class SignInViewController: UIViewController {
    
    @IBOutlet weak var signInEmail : UITextField!
    @IBOutlet weak var signInPassword : UITextField!
    @IBOutlet weak var forgotPassword : UIButton!
    @IBOutlet weak var signInButton : UIButton!
    @IBOutlet weak var facebookSignInView : UIView! = FBSDKLoginButton()
    @IBOutlet weak var twitterSignInView : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInitialView()
    }
  
    
    /**
     Initial Setup For the view components
     */
    func setupInitialView() {
        signInButton.layer.cornerRadius = CGFloat(5)
        
        facebookSignInView.layer.borderWidth = 2
        facebookSignInView.layer.cornerRadius = CGFloat(5)
        facebookSignInView.layer.borderColor = UIColor .lightGrayColor().CGColor
        
        twitterSignInView.layer.borderWidth = 2
        twitterSignInView.layer.cornerRadius = CGFloat(5)
        twitterSignInView.layer.borderColor = UIColor .lightGrayColor().CGColor
        
        let tap = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
        facebookSignInView.addGestureRecognizer(tap)
    }
    
    func handleTap(gestureRecognizer: UITapGestureRecognizer) {
        
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        let fbReadPermissions = ["user_work_history", "user_location", "user_education_history", "email", "user_birthday", "user_friends"]
        fbLoginManager .logInWithReadPermissions(fbReadPermissions, fromViewController: self) { (result, error) -> Void in
            if (error == nil){
                let fbLoginResult : FBSDKLoginManagerLoginResult = result
                if(fbLoginResult.grantedPermissions.contains("email")) {
                    self.getFBUserData()
                }
            }
        }
    }
    
    func getFBUserData() {
        
        let params = ["fields": "id, name, first_name, last_name, picture.type(large), email, work, location, education, friends, birthday, gender"]
        
        if((FBSDKAccessToken.currentAccessToken()) != nil) {
            FBSDKGraphRequest(graphPath: "me", parameters: params).startWithCompletionHandler({(connection, result, error) -> Void in
                if (error != nil) {
                    print("Error: \(error)")
                } else {
                    print(result)
                }
            })
        }
    }

    
    
    @IBAction func cancelButtonTapped() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
