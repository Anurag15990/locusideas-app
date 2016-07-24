//
//  ProfileTableViewController.swift
//  client
//
//  Created by Neha Yadav on 07/02/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import UIKit

class DesignerProfileTableViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView : UICollectionView!
    
    var user: User!
    
    var viewModel: DesignerProfileViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        bindViewModel()
    }
    
    func setupNavigationBar() {
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 4.0/255.0, green: 158.0/255.0, blue: 143.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Lobster 1.4", size: 20)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_arrow_back_white_18pt"), style: .Plain, target: self, action: #selector(DesignerProfileTableViewController.backButtonPressed(_:)))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_info_outline_white_18pt"), style: .Plain, target: self, action: #selector(DesignerProfileTableViewController.infoButtonPressed(_:)))
        
        self.title = viewModel.fetchUserName()
    }
    
    func bindViewModel() {
        self.viewModel.projects.observe { (array) in
            self.collectionView.reloadData()
        }
    }
    
    func backButtonPressed(sender: UIButton) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    func infoButtonPressed(sender: UIButton) {
        let vc = storyboard?.instantiateViewControllerWithIdentifier("DesignerInfoDetailTableViewController") as! DesignerInfoDetailTableViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch  section{
        case 0:
            return 1
        case 1:
            return viewModel.projects.array.count
        default:
            return 0
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        switch  indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("DesignerProfileHeaderCell", forIndexPath: indexPath) as! DesignerProfileHeaderCell
            
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
            cell.followButton.setAttributedTitle(viewModel.constructFollowButtonText(), forState: .Normal)
            
            cell.locationLabelHeightConstraint.constant = viewModel.fetchLocationLabelHeight()
            cell.locationLabelTopConstraint.constant = viewModel.fetchLocationLabelPadding()
            
            cell.locationLabel.textAlignment = .Center
            return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("DesignerProfileProjectsCell", forIndexPath: indexPath) as! DesignerProfileProjectsCell
            let project = viewModel.projects.array[indexPath.row]
            cell.projectName.text = viewModel.fetchProjectName(project)
            
            if let initialImageUrl = viewModel.fetchProjectInitialImage(project) {
                cell.coverImage.kf_setImageWithURL(NSURL(string: initialImageUrl)!, placeholderImage: UIImage(named: "Placeholder"))
            } else {
                cell.coverImage.image = UIImage(named: "Placeholder")
            }
            
            return cell
        default:
            return UICollectionViewCell()
        }
        
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSizeMake(UIScreen.mainScreen().bounds.width, 300)
            
        case 1:
            return CGSizeMake(UIScreen.mainScreen().bounds.width/2, UIScreen.mainScreen().bounds.width/2)
        
        default:
            return CGSizeZero
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 {
            let vc = storyboard?.instantiateViewControllerWithIdentifier("ProjectDetailsTableViewController") as! ProjectDetailsTableViewController
            let project = viewModel.projects.array[indexPath.row]
            vc.project = project
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsZero
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "headerView", forIndexPath: indexPath)
        return headerView
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 1 {
            return CGSizeMake(UIScreen.mainScreen().bounds.width,40)
        }
        return CGSizeZero
    }
}
