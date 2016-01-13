//
//  SignUpViewController.swift
//  client
//
//  Created by Neha Yadav on 06/01/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation
import UIKit

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
    }

}