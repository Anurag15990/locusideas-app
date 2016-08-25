//
//  EditProfileViewController.swift
//  client
//
//  Created by Anurag Agnihotri on 25/08/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_arrow_back_white_18pt"), style: .Plain, target: self, action: #selector(EditProfileViewController.backButtonPressed(_:)))
        self.title = "Edit Profile."
        
        let nextLabel = UIButton(frame: CGRectMake(0, 0, 50, 50))
        nextLabel.titleLabel!.font = UIFont(name: "MaterialDesignIcons", size: 25)
        nextLabel.setTitle("", forState: .Normal)
        nextLabel.addTarget(self, action: #selector(EditProfileViewController.updateUser), forControlEvents: .TouchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: nextLabel)
    }
    
    func backButtonPressed(sender: UIButton) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    func updateUser() {
        
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
