//
//  SignUpViewController.swift
//  client
//
//  Created by Neha Yadav on 06/01/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation
import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class SignUpViewController : UIViewController {
    
    @IBOutlet weak var signUpName : UITextField!
    @IBOutlet weak var signUpEmail : UITextField!
    @IBOutlet weak var signUpPassword : UITextField!
    @IBOutlet weak var confirmPassword : UITextField!
    @IBOutlet weak var signUpButton : UIButton!
    @IBOutlet weak var facebookSignUpView : UIView!
    @IBOutlet weak var twitterSignUpView : UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInitialView()
        
    }

    
    /**
     Setup Initial State of the View.
     */
    func setupInitialView() {
        signUpButton.layer.cornerRadius = CGFloat(5)
        
        facebookSignUpView.layer.borderWidth = 2
        facebookSignUpView.layer.cornerRadius = CGFloat(5)
        facebookSignUpView.layer.borderColor = UIColor .lightGrayColor().CGColor
        
        twitterSignUpView.layer.borderWidth = 2
        twitterSignUpView.layer.cornerRadius = CGFloat(5)
        twitterSignUpView.layer.borderColor = UIColor .lightGrayColor().CGColor
        
        let tap = UITapGestureRecognizer(target: self, action: "handleTap:")
        self.facebookSignUpView.addGestureRecognizer(tap)
        
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