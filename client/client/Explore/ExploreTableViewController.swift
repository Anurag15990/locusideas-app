//
//  ExploreTableViewController.swift
//  client
//
//  Created by Neha Yadav on 07/02/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import UIKit

class ExploreTableViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView : UITableView!
    
    var viewModel: ExploreDesignersViewModel!

    @IBOutlet weak var loaderContainerView: LoaderView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        viewModel = ExploreDesignersViewModel()
        tableView.registerNib(UINib(nibName: "ExploreDesignersCard", bundle: nil), forCellReuseIdentifier: "ExploreDesignersCard")
        tableView.separatorStyle = .None
        
        setupNavigationBar()
        bindViewModel()
    }
    
    /**
     Method to setup Navigation Bar.
     */
    func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = UIColor(red: 4.0/255.0, green: 158.0/255.0, blue: 143.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Lobster 1.4", size: 20)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.title = "Designers"
    }
    
    /**
     Method to Bind View Model With UI.
     */
    func bindViewModel() {
        viewModel.designersObservableArray.lift().bindTo(tableView) { indexPath, dataSource, tableView in
            let cell = tableView.dequeueReusableCellWithIdentifier("ExploreDesignersCard", forIndexPath: indexPath) as! ExploreDesignersCard
            let user = dataSource[indexPath.section][indexPath.row]
            
            if let coverImageUrl = self.viewModel.fetchUserCoverImageUrl(user) {
                cell.designCarouselView.kf_setImageWithURL(NSURL(string: coverImageUrl)!)
            } else {
                cell.designCarouselView.image = nil
            }
            
            if let profilePictureUrl = self.viewModel.fetchUserProfilePictureUrl(user) {
                cell.designerProfileImage.kf_setImageWithURL(NSURL(string: profilePictureUrl)!)
            } else {
                cell.designerProfileImage.image = nil
            }
            
            cell.designerNameLabel.text = self.viewModel.fetchUserName(user)
            return cell
        }
        
        viewModel.progressObservable.observe { (progressStatus) in
            switch progressStatus {
            case .None:
                break
                
            case .InProgress:
                self.loaderContainerView.hidden = false
                break
                
            case .Finished:
                self.loaderContainerView.hidden = true
                break
            }
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 295
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let vc = storyboard?.instantiateViewControllerWithIdentifier("DesignerProfileTableViewController") as! DesignerProfileTableViewController
        let designerViewModel = DesignerProfileViewModel(user: viewModel.designersObservableArray[indexPath.row])
        vc.viewModel = designerViewModel
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        if maximumOffset - currentOffset <= 0 {
            if let total = viewModel.paging?.total {
                if viewModel.designersObservableArray.array.count < total {
                    viewModel.fetchNextSetOfUsers()
                }
            }
        }
    }
}
