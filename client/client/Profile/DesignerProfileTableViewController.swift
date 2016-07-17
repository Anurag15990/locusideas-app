//
//  ProfileTableViewController.swift
//  client
//
//  Created by Neha Yadav on 07/02/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import UIKit

class DesignerProfileTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView : UITableView!
    
    var user: User!
    
    var viewModel: DesignerProfileViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: "DesignerProfileInfoCard", bundle: nil), forCellReuseIdentifier: "DesignerProfileInfoCard")
        tableView.registerNib(UINib(nibName: "ProjectHeaderView", bundle: nil), forCellReuseIdentifier: "ProjectHeaderView")
        tableView.registerNib(UINib(nibName: "StreamDesignCard", bundle: nil), forCellReuseIdentifier: "StreamDesignCard")
        
        
        tableView.separatorStyle = .None
        
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 4.0/255.0, green: 158.0/255.0, blue: 143.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Lobster 1.4", size: 20)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_arrow_back_white_18pt"), style: .Plain, target: self, action: #selector(DesignerProfileTableViewController.backButtonPressed(_:)))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_info_outline_white_18pt"), style: .Plain, target: self, action: #selector(DesignerProfileTableViewController.infoButtonPressed(_:)))
        
        self.title = viewModel.fetchUserName()
    }
    
    func backButtonPressed(sender: UIButton) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    func infoButtonPressed(sender: UIButton) {
        let vc = storyboard?.instantiateViewControllerWithIdentifier("DesignerInfoDetailTableViewController") as! DesignerInfoDetailTableViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 300
            
        } else if indexPath.row == 1 {
            return 36
        } else {
            return 430
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("DesignerProfileHeaderCell", forIndexPath: indexPath) as! DesignerProfileHeaderCell
            
            if let coverImageUrl = self.viewModel.fetchUserCoverImageUrl() {
                cell.coverImageView.kf_setImageWithURL(NSURL(string: coverImageUrl)!, placeholderImage: UIImage(named: "Placeholder"))
            } else {
                cell.coverImageView.image = UIImage(named: "Placeholder")
            }
            
            if let profilePictureUrl = self.viewModel.fetchUserProfilePictureUrl() {
                cell.profilePictureImageView.kf_setImageWithURL(NSURL(string: profilePictureUrl)!)
            }
            
            cell.nameLabel.text = viewModel.fetchUserName()
            cell.locationLabel.attributedText = viewModel.fetchLocationText()
            
            cell.locationLabelHeightConstraint.constant = viewModel.fetchLocationLabelHeight()
            cell.locationLabelTopConstraint.constant = viewModel.fetchLocationLabelPadding()
            
            cell.locationLabel.textAlignment = .Center
            return cell
        
        } else if indexPath.row == 1 {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("ProjectHeaderView", forIndexPath: indexPath) as! ProjectHeaderView
            return cell
        
        } else {
        
            let cell = tableView.dequeueReusableCellWithIdentifier("StreamDesignCard", forIndexPath: indexPath) as! StreamDesignCard
            return cell
        
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row > 1 {
            let vc = storyboard?.instantiateViewControllerWithIdentifier("ProjectDetailsTableViewController") as! ProjectDetailsTableViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
