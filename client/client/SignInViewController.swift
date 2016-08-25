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
import Alamofire

class SignInViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {
    
    @IBOutlet weak var signInEmail : UITextField!
    @IBOutlet weak var signInPassword : UITextField!
    @IBOutlet weak var forgotPassword : UIButton!
    @IBOutlet weak var signInButton : UIButton!
    @IBOutlet weak var facebookSignInView : UIView! = FBSDKLoginButton()
    @IBOutlet weak var googleSignInView : UIView!
    
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
     Initial Setup For the view components
     */
    func setupInitialView() {
        signInButton.layer.cornerRadius = CGFloat(5)
        
        facebookSignInView.layer.borderWidth = 2
        facebookSignInView.layer.cornerRadius = CGFloat(5)
        facebookSignInView.layer.borderColor = UIColor .lightGrayColor().CGColor
        
        googleSignInView.layer.borderWidth = 2
        googleSignInView.layer.cornerRadius = CGFloat(5)
        googleSignInView.layer.borderColor = UIColor .lightGrayColor().CGColor
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(SignInViewController.handleTap(_:)))
        facebookSignInView.addGestureRecognizer(tap)
        
        let googleTap = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.handleGoogleTap(_:)))
        self.googleSignInView.addGestureRecognizer(googleTap)
    }
    
    func handleGoogleTap(gestureRecognizer: UITapGestureRecognizer) {
        GIDSignIn.sharedInstance().signIn()
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
    
    func authenticateWithFacebook(request: FacebookAuthRequestBody) {

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
    
    func loginWithEmail(request: EmailSignInAuthRequestBody) {
        self.loaderContainerView.hidden = false
        AuthService.sharedInstance.loginWithEmail(request, successCallback: { (token) in
            self.getUserDetails()
            }) { (error) in
                print(error.localizedDescription)
        }
    }
    
    func getUserDetails() {
        UserService.sharedInstance.getMeRequest({ (user) in
            self.loaderContainerView.hidden = true
            self.redirectBasedOnOnboardingStatus()
            })
        { (error) in
                print(error)
        }
    }
    
    @IBAction func signInButtonTapped() {
        
        if !ValidationUtils.isEmptyTextField(signInEmail) && ValidationUtils.isValidEmail(signInEmail.text!) && !ValidationUtils.isEmptyTextField(signInPassword) {
            
            let signInRequestBody = EmailSignInAuthRequestBody()
            signInRequestBody.emailId = signInEmail.text
            signInRequestBody.password = signInPassword.text
            
            self.loginWithEmail(signInRequestBody)
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