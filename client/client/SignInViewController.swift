//
//  LoginViewController.swift
//  client
//
//  Created by Neha Yadav on 06/01/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation
import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet weak var signInEmail : UITextField!
    @IBOutlet weak var signInPassword : UITextField!
    @IBOutlet weak var forgotPassword : UIButton!
    @IBOutlet weak var signInButton : UIButton!
    @IBOutlet weak var facebookSignInView : UIView!
    @IBOutlet weak var twitterLoginView : UIView!
    
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
        
        twitterLoginView.layer.borderWidth = 2
        twitterLoginView.layer.cornerRadius = CGFloat(5)
        twitterLoginView.layer.borderColor = UIColor .lightGrayColor().CGColor
    }
    
    @IBAction func cancelButtonTapped() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
