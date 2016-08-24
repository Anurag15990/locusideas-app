//
//  SelectCategoriesViewController.swift
//  client
//
//  Created by Anurag Agnihotri on 24/08/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import UIKit
import TTGTagCollectionView

class SelectCategoriesViewController: UIViewController {

    @IBOutlet weak var tagCollectionView: TTGTextTagCollectionView!
    
    var categories = [Category]()
    
    var viewModel: OnboardingViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        initialSetup()
        fetchCategories()
        // Do any additional setup after loading the view.
    }
    
    func initialSetup() {
        tagCollectionView.enableTagSelection = true
        tagCollectionView.extraSpace = CGSizeMake(8, 8)
        tagCollectionView.tagTextColor = UIColor(red: 0.0/255.0, green: 197.0/255.0, blue: 191.0/255.0, alpha: 1.0)
        tagCollectionView.tagTextFont = UIFont(name: "Arial Rounded MT Bold", size: 16)
        tagCollectionView.tagBorderColor = UIColor(red: 0.0/255.0, green: 197.0/255.0, blue: 191.0/255.0, alpha: 1.0)
        tagCollectionView.tagBorderWidth = 1.0
        tagCollectionView.tagCornerRadius = 4.0
        tagCollectionView.tagSelectedTextColor = UIColor.whiteColor()
        tagCollectionView.tagBackgroundColor = UIColor.whiteColor()
        tagCollectionView.tagSelectedBackgroundColor = UIColor(red: 0.0/255.0, green: 197.0/255.0, blue: 191.0/255.0, alpha: 1.0)
        tagCollectionView.horizontalSpacing = 4.0
        tagCollectionView.verticalSpacing = 8.0
        
        tagCollectionView.delegate = self
    }

    func setupNavigationBar() {
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_arrow_back_white_18pt"), style: .Plain, target: self, action: #selector(SelectCategoriesViewController.backButtonPressed(_:)))
        self.title = "Select Categories."
        
        let nextLabel = UIButton(frame: CGRectMake(0, 0, 50, 50))
        nextLabel.titleLabel!.font = UIFont(name: "MaterialDesignIcons", size: 25)
        nextLabel.setTitle("", forState: .Normal)
        nextLabel.addTarget(self, action: #selector(SelectCategoriesViewController.setCategories), forControlEvents: .TouchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: nextLabel)
        
    }
    
    func backButtonPressed(sender: UIButton) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchCategories() {
        
        CategoriesService.sharedInstance.fetchCategories({ (categories) in
            
            self.categories = categories
            
            for category in self.categories {
                self.tagCollectionView.addTag(category.name)
            }
            
            self.tagCollectionView.reload()
            
            }) { (error) in
                print(error.localizedDescription)
        }
    }
    
    func setCategories() {
        
        var categoryNames = [String]()
        
        for category in categories {
            if category.selected! {
                categoryNames.append(category.name!)
            }
        }
        
        self.viewModel.setCategoriesInRequestBody(categoryNames)
        print(self.viewModel.onboardingRequestBody.preferences?.categories)
        self.navigateToEnterBioViewController()
    }
    
    func navigateToEnterBioViewController() {
        let vc = storyboard?.instantiateViewControllerWithIdentifier("EnterBioViewController") as! EnterBioViewController
        vc.viewModel = self.viewModel
        self.navigationController?.pushViewController(vc, animated: true)
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

extension SelectCategoriesViewController: TTGTextTagCollectionViewDelegate {
    
    func textTagCollectionView(textTagCollectionView: TTGTextTagCollectionView!, didTapTag tagText: String!, atIndex index: UInt, selected: Bool) {
        categories[Int(index)].selected = selected
    }
    
    func textTagCollectionView(textTagCollectionView: TTGTextTagCollectionView!, updateContentHeight newContentHeight: CGFloat) {
        
    }
}
