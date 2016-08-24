//
//  EnterBioViewController.swift
//  client
//
//  Created by Anurag Agnihotri on 24/08/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import UIKit
import NextGrowingTextView


class EnterBioViewController: UIViewController {
    
    @IBOutlet weak var inputContainerView: UIView!
    @IBOutlet weak var inputContainerViewBottom: NSLayoutConstraint!
    @IBOutlet weak var growingTextView: NextGrowingTextView!


    var viewModel: OnboardingViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        initialSetup()
        
        // Do any additional setup after loading the view.
    }

    func setupNavigationBar() {
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_arrow_back_white_18pt"), style: .Plain, target: self, action: #selector(SelectCategoriesViewController.backButtonPressed(_:)))
        
        let nextLabel = UIButton(frame: CGRectMake(0, 0, 50, 50))
        nextLabel.titleLabel!.font = UIFont(name: "MaterialDesignIcons", size: 25)
        nextLabel.setTitle("", forState: .Normal)
        nextLabel.addTarget(self, action: #selector(EnterBioViewController.setBio), forControlEvents: .TouchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: nextLabel)
        
    }
    
    func initialSetup() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(EnterBioViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(EnterBioViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        
        self.growingTextView.layer.cornerRadius = 4
        self.growingTextView.textColor = UIColor(red: 73.0/255.0, green: 149.0/255.0, blue: 144.0/255.0, alpha: 1.0)
        self.growingTextView.font = UIFont(name: "Arial Rounded MT Bold", size: 14)!
        self.growingTextView.backgroundColor = UIColor(red: 249.0/255.0, green: 249.0/255.0, blue: 249.0/255.0, alpha: 1.0)
        self.growingTextView.textContainerInset = UIEdgeInsets(top: 8, left: 4, bottom: 8, right: 4)
        self.growingTextView.placeholderAttributedText = NSAttributedString(string: "Write something about yourself...",
                                                                            attributes: [NSFontAttributeName: UIFont(name: "Arial Rounded MT Bold", size: 14)!,
                                                                                NSForegroundColorAttributeName: UIColor.grayColor()
            ]
        )
    }
    
    func setBio() {
        self.viewModel.setBio(self.growingTextView.text)
        print(viewModel.onboardingRequestBody.bio)
    }
    
    func backButtonPressed(sender: UIButton) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func keyboardWillHide(sender: NSNotification) {
        if let userInfo = sender.userInfo {
            if let _ = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue.size.height {
                //key point 0,
                self.inputContainerViewBottom.constant =  0
                //textViewBottomConstraint.constant = keyboardHeight
                UIView.animateWithDuration(0.25, animations: { () -> Void in self.view.layoutIfNeeded() })
            }
        }
    }
    func keyboardWillShow(sender: NSNotification) {
        if let userInfo = sender.userInfo {
            if let keyboardHeight = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue.size.height {
                self.inputContainerViewBottom.constant = keyboardHeight
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.view.layoutIfNeeded()
                })
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
