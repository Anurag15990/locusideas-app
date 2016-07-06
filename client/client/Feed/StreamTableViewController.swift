//
//  StreamTableViewController.swift
//  client
//
//  Created by Neha Yadav on 20/01/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import UIKit
import Kingfisher
import NVActivityIndicatorView

class StreamTableViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView : UITableView!
    
    var viewModel: StreamViewModel!
    
    var loaderContainerView: LoaderView!
    
    private var screenWidth = UIScreen.mainScreen().bounds.size.width
    private var imageViewHeight: CGFloat = 300
    
    override func viewDidLoad() {
        super.viewDidLoad()

        constructLoaderView()
        
        viewModel = StreamViewModel()
        
        setupNavigationBar()
        
        tableView.registerNib(UINib(nibName: "StreamDesignCard", bundle: nil), forCellReuseIdentifier: "StreamDesignCard")
        tableView.separatorStyle = .None
        
        bindViewModel()
    }
    
    /**
     Method to setup Navigation Bar.
     */
    func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = UIColor(red: 4.0/255.0, green: 158.0/255.0, blue: 143.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Lobster 1.4", size: 20)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.title = "Designs"
    }
    

    func bindViewModel() {
        
        viewModel.streamArrayObservable.lift().bindTo(tableView) { indexPath, dataSource, tableView in
            
            let cell = tableView.dequeueReusableCellWithIdentifier("StreamDesignCard", forIndexPath: indexPath) as! StreamDesignCard
            
            let project = dataSource[indexPath.section][indexPath.row]
            
            if let url = self.viewModel.fetchProjectPictureUrl(project) {
                cell.designCoverImage.kf_setImageWithURL(NSURL(string: url)!)
            }
            
            if let title = self.viewModel.fetchProjectTitle(project) {
                cell.designTitleLabel.text = title
            }
            
            cell.designerNameLabel.text = self.viewModel.fetchProjectOwnerName(project)
            
            return cell
        }
        
        viewModel.progressObservable.observe { (progress) in
            switch progress {
            case .None:
                break
                
            case .InProgress:
                self.loaderContainerView.hidden = false
                self.view.bringSubviewToFront(self.loaderContainerView)
                break
                
            case .Finished:
                self.loaderContainerView.hidden = true
                break
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func constructLoaderView() {
        loaderContainerView = LoaderView(frame: self.view.frame)
        self.view.addSubview(loaderContainerView)
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let project = viewModel.streamArrayObservable.array[indexPath.row]
        if let media = project.medias?.initial?.first?.media {
            let imageRatio: CGFloat = CGFloat(media.height!) / CGFloat(media.width!)
            if imageRatio == 0 || imageRatio < 0 {
                return imageViewHeight + 103
            }
            return screenWidth * imageRatio + 103
        }
        return 430
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let vc = storyboard?.instantiateViewControllerWithIdentifier("ProjectDetailsTableViewController") as! ProjectDetailsTableViewController
        let project = viewModel.streamArrayObservable.array[indexPath.row]
        vc.project = project
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        if maximumOffset - currentOffset <= 0 {
            if let total = viewModel.paging?.total {
                if viewModel.streamArrayObservable.array.count < total {
                    viewModel.fetchNextSetOfProjects()
                }
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
