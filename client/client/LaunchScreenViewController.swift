//
//  LaunchScreenViewController.swift
//  client
//
//  Created by Neha Yadav on 13/01/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController, UIPageViewControllerDataSource {
    
    @IBOutlet weak var skipButton : UIButton!
    @IBOutlet weak var signInButton : UIButton!
    @IBOutlet weak var signUpButton : UIButton!
    @IBOutlet weak var pageNavigator: UIPageControl!
    
    private var pageViewController: UIPageViewController?
    
    private let contentImages = ["Splash_image_1.jpg",
                                 "Splash_image_2.jpg",
                                 "Splash_image_3.jpg",
                                 "Splash_image_4.jpg"]

    override func viewDidLoad() {
        super.viewDidLoad()
        createPageViewController()
        // Do any additional setup after loading the view.
    }
    
    
    private func createPageViewController() {
        let pageController = self.storyboard!.instantiateViewControllerWithIdentifier("PageController") as! UIPageViewController
        pageController.dataSource = self
        
        if contentImages.count > 0 {
            let firstController = getImageController(0)
            let startingViewControllers: NSArray = [firstController!]
            pageController.setViewControllers(startingViewControllers as? [UIViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        }
        
        pageViewController = pageController
        self.pageViewController?.view.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        addChildViewController(pageViewController!)
        self.view.addSubview(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)
        view.bringSubviewToFront(skipButton)
        view.bringSubviewToFront(pageNavigator)
        view.sendSubviewToBack(pageViewController!.view)
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let imageController = viewController as! LaunchScreenContentViewController
        if imageController.imageIndex > 0 {
            return getImageController(imageController.imageIndex-1)
        }
        
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let imageController = viewController as! LaunchScreenContentViewController
        if imageController.imageIndex+1 < contentImages.count {
            return getImageController(imageController.imageIndex+1)
        }
        
        return nil
    }
    
    private func getImageController(imageIndex: Int) -> LaunchScreenContentViewController? {
        
        if imageIndex < contentImages.count {
            let launchScreenContentViewController = self.storyboard!.instantiateViewControllerWithIdentifier("ImageController") as! LaunchScreenContentViewController
            launchScreenContentViewController.imageIndex = imageIndex
            launchScreenContentViewController.imageName = contentImages[imageIndex]
            return launchScreenContentViewController
        }
        
        return nil
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return contentImages.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
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
