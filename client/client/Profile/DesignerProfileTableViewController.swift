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
        
        collectionView.registerNib(UINib(nibName: "DesignerBioCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DesignerBioCollectionViewCell")
        collectionView.registerNib(UINib(nibName: "DesignerSkillsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DesignerSkillsCollectionViewCell")

        
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
        vc.viewModel = self.viewModel
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return self.viewModel.sections.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch  self.viewModel.sections[section]{
        case .HeaderSection:
            return 1
        case .AboutSection:
            return 1
        case .SkillsSection:
            return viewModel.fetchUserSkills()!.count
        case .ProjectsSection:
            return viewModel.projects.array.count
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        switch  self.viewModel.sections[indexPath.section]{
        case .HeaderSection:
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
            cell.specializationLabel.text = viewModel.fetchUserSpecialization()
            cell.followButton.setAttributedTitle(viewModel.constructFollowButtonText(), forState: .Normal)
            
            cell.locationLabelHeightConstraint.constant = viewModel.fetchLocationLabelHeight()
            cell.locationLabelTopConstraint.constant = viewModel.fetchLocationLabelPadding()
            
            cell.locationLabel.textAlignment = .Center
            return cell
            
        case .AboutSection:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("DesignerBioCollectionViewCell", forIndexPath: indexPath) as! DesignerBioCollectionViewCell
            cell.bioLabel.text = viewModel.fetchUserBio()
            return cell
        case .SkillsSection:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("DesignerSkillsCollectionViewCell", forIndexPath: indexPath) as! DesignerSkillsCollectionViewCell
            cell.skillsTitleLabel.text = viewModel.fetchUserSkills()![indexPath.row].title
            return cell
        case .ProjectsSection:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("DesignerProfileProjectsCell", forIndexPath: indexPath) as! DesignerProfileProjectsCell
            let project = viewModel.projects.array[indexPath.row]
            cell.projectName.text = viewModel.fetchProjectName(project)
            
            if let initialImageUrl = viewModel.fetchProjectInitialImage(project) {
                cell.coverImage.kf_setImageWithURL(NSURL(string: initialImageUrl)!, placeholderImage: UIImage(named: "Placeholder"))
            } else {
                cell.coverImage.image = UIImage(named: "Placeholder")
            }
            
            return cell
        }
        
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        switch self.viewModel.sections[indexPath.section] {
        case .HeaderSection:
            return CGSizeMake(UIScreen.mainScreen().bounds.width, 300)
        
        case .AboutSection:
            return CGSizeMake(UIScreen.mainScreen().bounds.width, self.viewModel.fetchHeightForBioLabel())
        case .SkillsSection:
            return CGSizeMake(UIScreen.mainScreen().bounds.width/2, 56)
        case .ProjectsSection:
            return CGSizeMake(UIScreen.mainScreen().bounds.width/2, UIScreen.mainScreen().bounds.width/2)
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        switch  self.viewModel.sections[indexPath.section] {
        case .ProjectsSection:
            let vc = storyboard?.instantiateViewControllerWithIdentifier("ProjectDetailsTableViewController") as! ProjectDetailsTableViewController
            let project = viewModel.projects.array[indexPath.row]
            vc.project = project
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
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
        let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "headerView", forIndexPath: indexPath) as! DesignerProfileHeaderView
        switch self.viewModel.sections[indexPath.section] {
        case .AboutSection:
            headerView.titleLabel.text =  "ABOUT"
        case .SkillsSection:
            headerView.titleLabel.text = "SKILLS"
        case .ProjectsSection:
            headerView.titleLabel.text = "DESIGNS"
        default:
            break
        }
        return headerView
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch self.viewModel.sections[section] {
        case .ProjectsSection,
             .SkillsSection,
             .AboutSection:
            return CGSizeMake(UIScreen.mainScreen().bounds.width,40)
        default:
            return CGSizeZero
        }
    }
}
