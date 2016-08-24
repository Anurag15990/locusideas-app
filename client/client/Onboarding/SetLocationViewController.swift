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
    var locationManager =  CLLocationManager()
    var locationHeaderView = "MyProfileHeaderView"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        setupNavigationBar()
        
        viewModel = OnboardingViewModel()
        // Do any additional setup after loading the view.
    }
    
    func initializeLocationManager() {
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
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
        self.tableView.tableFooterView = UIView()
        self.searchBar.delegate = self
        
        tableView.registerNib(UINib(nibName: locationHeaderView, bundle: nil), forHeaderFooterViewReuseIdentifier: locationHeaderView)

    }

    func navigateToCategoriesView() {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("SelectCategoriesViewController") as! SelectCategoriesViewController
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

extension SetLocationViewController: UISearchBarDelegate {
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.googlePredictions.removeAll()
            self.tableView.reloadData()
            return
        }
        
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
        if googlePredictions.count > 0 {
            return 2
        }
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return googlePredictions.count
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("DetectLocationTableViewCell", forIndexPath: indexPath) as! DetectLocationTableViewCell
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("GooglePredictionsTableViewCell", forIndexPath: indexPath) as! GooglePredictionsTableViewCell
            cell.predictionLabel.attributedText = self.googlePredictions[indexPath.row].attributedPrimaryText
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            self.initializeLocationManager()
        } else {
            self.viewModel.setLocationInRequestBody(self.googlePredictions[indexPath.row].attributedPrimaryText.string)
            print(viewModel.onboardingRequestBody.preferences?.city)
            self.navigateToCategoriesView()
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterViewWithIdentifier(self.locationHeaderView) as! MyProfileHeaderView
        
        switch section {
            
        case 1:
            headerView.headerLabel.text = "Locations"
            
        default: break
            
        }
        
        return headerView

    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 1:
            return 40
        default:
            return 0
        }
    }

    
}

extension SetLocationViewController: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(manager.location!) { (placemarks, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            
            if placemarks!.count > 0 {
                let placeMark: CLPlacemark = placemarks![0] as CLPlacemark
                self.viewModel.setLocationInRequestBody(placeMark.locality!)
                print(self.viewModel.onboardingRequestBody.preferences?.city)
                self.navigateToCategoriesView()
            }
        }
    }
}
