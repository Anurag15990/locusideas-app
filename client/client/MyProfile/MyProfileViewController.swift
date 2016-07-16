//
//  MyProfileViewController.swift
//  client
//
//  Created by Neha Yadav on 22/02/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import UIKit

class MyProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView! 
    
    var profileHeaderCellIdentifier = "MyProfileHeaderCell"
    var profileContactInfoReusableCell = "ProfileContactInfoReusableCell"
    var profileHeaderView = "MyProfileHeaderView"
    var viewModel: MyProfileViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupNavigationBar()
        
        self.viewModel = MyProfileViewModel()
        tableView.registerNib(UINib(nibName: profileHeaderView, bundle: nil), forHeaderFooterViewReuseIdentifier: profileHeaderView)
        self.tableView.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.fetchNumberOfRowsForTableView(section)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 300
        }
        
        return 53
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch  indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier(self.profileHeaderCellIdentifier, forIndexPath: indexPath) as! MyProfileHeaderCell
            
            if let coverImageUrl = self.viewModel.fetchUserCoverImageUrl() {
                cell.coverImageView.kf_setImageWithURL(NSURL(string: coverImageUrl)!)
            }
            
            if let profilePictureUrl = self.viewModel.fetchUserProfilePictureUrl() {
                cell.profilePictureImageView.kf_setImageWithURL(NSURL(string: profilePictureUrl)!)
            }
            
            cell.nameLabel.text = self.viewModel.fetchUserName()
            cell.locationLabel.attributedText = self.viewModel.fetchUserLocation()
            
            return cell
            
        case 1:
            
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCellWithIdentifier(self.profileContactInfoReusableCell, forIndexPath: indexPath) as! ProfileContactInfoReusableCell
                cell.typeIconLabel.text = ""
                cell.dataLabel.text = self.viewModel.fetchUserEmail()
                return cell
                
            case 1:
                let cell = tableView.dequeueReusableCellWithIdentifier(self.profileContactInfoReusableCell, forIndexPath: indexPath) as! ProfileContactInfoReusableCell
                cell.typeIconLabel.text = ""
                cell.dataLabel.text = self.viewModel.fetchUserPrimaryContact()
                return cell
                
            default: return UITableViewCell()
            
            }
            
        case 2:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCellWithIdentifier(self.profileContactInfoReusableCell, forIndexPath: indexPath) as! ProfileContactInfoReusableCell
                cell.typeIconLabel.text = ""
                cell.dataLabel.text = self.viewModel.fetchUserWebsite()
                return cell
            default:
                let cell = tableView.dequeueReusableCellWithIdentifier(self.profileContactInfoReusableCell, forIndexPath: indexPath) as! ProfileContactInfoReusableCell
                if let socialObject = viewModel.fetchUserSocialLink(indexPath.row - 1) {
                    cell.typeIconLabel.text = socialObject.0
                    cell.dataLabel.text = socialObject.1
                }
                return cell
            }
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterViewWithIdentifier(self.profileHeaderView) as! MyProfileHeaderView
        
        switch section {
        case 1:
            headerView.headerLabel.text = "Contact Information"
        
        case 2:
            headerView.headerLabel.text = "Social Information"
        
        default: break
        
        }
        
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 1,2:
            return 21
        default:
            return 0
        }
    }
    
    /*
     * Function to Setup Navigation Bar.
     */
    func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = UIColor(red: 4.0/255.0, green: 158.0/255.0, blue: 143.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Lobster 1.4", size: 20)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.title = "Profile"
        
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_settings_white_18pt"), style: .Plain, target: self, action: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
