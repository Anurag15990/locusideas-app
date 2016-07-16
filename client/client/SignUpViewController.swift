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
import Alamofire

class SignUpViewController : UIViewController {
    
    @IBOutlet weak var signUpName : UITextField!
    @IBOutlet weak var signUpEmail : UITextField!
    @IBOutlet weak var signUpPassword : UITextField!
    @IBOutlet weak var confirmPassword : UITextField!
    @IBOutlet weak var signUpButton : UIButton!
    @IBOutlet weak var facebookSignUpView : UIView!
    @IBOutlet weak var twitterSignUpView : UIView!
    
    var loaderContainerView: LoaderView!

    override func viewDidLoad() {
        super.viewDidLoad()
        constructLoaderView()
        setupInitialView()
        
    }

    func constructLoaderView() {
        loaderContainerView = LoaderView(frame: self.view.frame)
        self.view.addSubview(loaderContainerView)
        loaderContainerView.hidden = true
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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.handleTap(_:)))
        self.facebookSignUpView.addGestureRecognizer(tap)
        
    }
    
    func handleTap(gestureRecognizer: UITapGestureRecognizer) {
        
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        let fbReadPermissions = ["user_work_history", "user_location", "user_education_history", "email", "user_birthday", "user_friends"]
        fbLoginManager.logInWithReadPermissions(fbReadPermissions, fromViewController: self) { (result, error) -> Void in
            if (error == nil){
                let fbLoginResult : FBSDKLoginManagerLoginResult = result
                if(fbLoginResult.grantedPermissions.contains("email")) {
                    self.getFBUserData()
                }
            }
        }
    }
    
    func getFBUserData() {
        loaderContainerView.hidden = false
        let params = ["fields": "id, name, first_name, last_name, picture.type(large), email, work, location, education, friends, birthday, gender"]
        
        if((FBSDKAccessToken.currentAccessToken()) != nil) {
            FBSDKGraphRequest(graphPath: "me", parameters: params).startWithCompletionHandler({(connection, result, error) -> Void in
                if (error != nil) {
                    print("Error: \(error)")
                } else {
                    let facebookAuthRequestBody = FacebookAuthRequestBody()
                    facebookAuthRequestBody.id = result.valueForKey("id") as? String
                    facebookAuthRequestBody.accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                    self.authenticateWithFacebook(facebookAuthRequestBody)
                }
            })
        }
    }
    
    func authenticateWithFacebook(request: FacebookAuthRequestBody){

        AuthService.sharedInstance.loginWithFacebook(request, successCallback: { (token) in
            self.loaderContainerView.hidden = true
            self.getUserDetails()
            self.pushToTabView()
            }) { (error) in
                print(error.localizedDescription)
        }
    }
    
    func registerWithEmail(request: EmailSignUpAuthRequestBody) {
        self.loaderContainerView.hidden = false
        AuthService.sharedInstance.registerWithEmail(request, successCallback: { (token) in
            self.getUserDetails()
            self.loaderContainerView.hidden = true
            self.pushToTabView()
            }) { (error) in
                print(error.localizedDescription)
        }
    }
    
    func getUserDetails() {
        UserService.sharedInstance.getMeRequest({ (user) in }) { (error) in
                print(error.localizedDescription)
        }
    }
    
    @IBAction func signUpButtonTapped() {
    
        if !ValidationUtils.isEmptyTextField(signUpEmail) && ValidationUtils.isValidEmail(signUpEmail.text!) && !ValidationUtils.isEmptyTextField(signUpPassword) && !ValidationUtils.isEmptyTextField(signUpName) && !ValidationUtils.isEmptyTextField(confirmPassword) {
            
            let signUpRequestBody = EmailSignUpAuthRequestBody()
            signUpRequestBody.emailId = signUpEmail.text
            signUpRequestBody.password = signUpPassword.text
            
            self.registerWithEmail(signUpRequestBody)
        } else {
            print("Validation Failed!")
        }
    }
    
    func pushToTabView() {
        
        let vc = storyboard?.instantiateViewControllerWithIdentifier("TabBarController") as! UITabBarController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonTapped() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}