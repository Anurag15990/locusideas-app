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

class SignUpViewController : UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {
    
    @IBOutlet weak var signUpName : UITextField!
    @IBOutlet weak var signUpEmail : UITextField!
    @IBOutlet weak var signUpPassword : UITextField!
    @IBOutlet weak var confirmPassword : UITextField!
    @IBOutlet weak var signUpButton : UIButton!
    @IBOutlet weak var facebookSignUpView : UIView!
    @IBOutlet weak var googleSignUpView : UIView!
    
    var loaderContainerView: LoaderView!

    override func viewDidLoad() {
        super.viewDidLoad()
        constructLoaderView()
        setupInitialView()
        initializeGoogleSignInDelegate()
        
    }

    func constructLoaderView() {
        loaderContainerView = LoaderView(frame: self.view.frame)
        self.view.addSubview(loaderContainerView)
        loaderContainerView.hidden = true
    }
    
    func initializeGoogleSignInDelegate() {
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
    }

    
    /**
     Setup Initial State of the View.
     */
    func setupInitialView() {
        signUpButton.layer.cornerRadius = CGFloat(5)
        
        facebookSignUpView.layer.borderWidth = 2
        facebookSignUpView.layer.cornerRadius = CGFloat(5)
        facebookSignUpView.layer.borderColor = UIColor .lightGrayColor().CGColor
        
        googleSignUpView.layer.borderWidth = 2
        googleSignUpView.layer.cornerRadius = CGFloat(5)
        googleSignUpView.layer.borderColor = UIColor .lightGrayColor().CGColor
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.handleTap(_:)))
        self.facebookSignUpView.addGestureRecognizer(tap)
        
        let googleTap = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.handleGoogleTap(_:)))
        self.googleSignUpView.addGestureRecognizer(googleTap)
    }
    
    func handleGoogleTap(gestureRecognizer: UITapGestureRecognizer) {
        GIDSignIn.sharedInstance().signIn()
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
            self.getUserDetails()
            }) { (error) in
                print(error.localizedDescription)
        }
    }
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
        //TODO: Actual Sign Up to be done.
        
        loaderContainerView.hidden = false
        
        let requestBody = GoogleAuthRequestBody()
        requestBody.id = user.userID
        requestBody.accessToken = user.authentication.accessToken
        requestBody.refreshToken = user.authentication.refreshToken
        self.authenticateWithGoogle(requestBody)
    }
    
    func authenticateWithGoogle(request: GoogleAuthRequestBody) {
        
        AuthService.sharedInstance.loginWithGoogle(request, successCallback: { (token) in
            self.getUserDetails()
            }) { (error) in
                print(error.localizedDescription)
        }
    }
    
    func registerWithEmail(request: EmailSignUpAuthRequestBody) {
        self.loaderContainerView.hidden = false
        AuthService.sharedInstance.registerWithEmail(request, successCallback: { (token) in
            self.getUserDetails()
            }) { (error) in
                print(error.localizedDescription)
        }
    }
    
    func getUserDetails() {
        UserService.sharedInstance.getMeRequest({ (user) in
            self.loaderContainerView.hidden = true
            self.redirectBasedOnOnboardingStatus()
        }) { (error) in
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
    
    func redirectBasedOnOnboardingStatus() {
        if let _ = UserService.getUser()?.onboardedAt {
            pushToTabView()
        } else {
            pushToOnboardingView()
        }
    }
    
    
    func pushToOnboardingView() {
        let vc = storyboard?.instantiateViewControllerWithIdentifier("LocationNavigationController") as! UINavigationController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func pushToTabView() {
        
        let vc = storyboard?.instantiateViewControllerWithIdentifier("TabBarController") as! UITabBarController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonTapped() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}