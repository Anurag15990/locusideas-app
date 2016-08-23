//
//  SetLocationViewController.swift
//  client
//
//  Created by Anurag Agnihotri on 23/08/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import UIKit
import GooglePlaces

class SetLocationViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var googlePredictions = [GMSAutocompletePrediction]()
    
    var viewModel: OnboardingViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        setupNavigationBar()
        
        viewModel = OnboardingViewModel()
        // Do any additional setup after loading the view.
    }
    
    /**
     Method to setup Navigation Bar.
     */
    func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = UIColor(red: 4.0/255.0, green: 158.0/255.0, blue: 143.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Lobster 1.4", size: 20)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.title = "Select A Location"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initialSetup() {
        self.searchBar.delegate = self
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

extension SetLocationViewController: UISearchBarDelegate {
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        GooglePlacesServices.sharedInstance.getPlaces(searchText, successCallback: { (predictions) in
            
            self.googlePredictions = predictions
            self.tableView.reloadData()
            
        }) { (error) in
        
            print(error.localizedDescription)
        }
    }
}

extension SetLocationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return googlePredictions.count + 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("DetectLocationTableViewCell", forIndexPath: indexPath) as! DetectLocationTableViewCell
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("GooglePredictionsTableViewCell", forIndexPath: indexPath) as! GooglePredictionsTableViewCell
            cell.predictionLabel.attributedText = self.googlePredictions[indexPath.row - 1].attributedPrimaryText
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            
        } else {
            self.viewModel.setLocationInRequestBody(self.googlePredictions[indexPath.row - 1].attributedPrimaryText.string)
            print(viewModel.onboardingRequestBody.preferences?.city)
        }
    }
}
