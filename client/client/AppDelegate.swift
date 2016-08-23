//
//  AppDelegate.swift
//  client
//
//  Created by Anurag Agnihotri on 12/26/15.
//  Copyright © 2015 LocusIdeas. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        UITabBar.appearance().tintColor = UIColor(red: 2.0/255.0, green: 193.0/255.0, blue: 186.0/255.0, alpha: 1.0)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "Asap-Medium", size: 13)!], forState: .Normal)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red: 2.0/255.0, green: 193.0/255.0, blue: 186.0/255.0, alpha: 1.0)], forState: .Selected)
        
        NSThread.sleepForTimeInterval(2.0)
        
        redirectBasedOnLoginStatus()
        
        GMSPlacesClient.provideAPIKey(GoogleConstants.googlePlacesAPIKey)
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
    }
    
    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
        
        if #available(iOS 9.0, *) {
            return GIDSignIn.sharedInstance().handleURL(url, sourceApplication: (options[UIApplicationOpenURLOptionsSourceApplicationKey] as? String), annotation: options[UIApplicationOpenURLOptionsAnnotationKey])
        } else {
            // Fallback on earlier versions
            return GIDSignIn.sharedInstance().handleURL(url, sourceApplication: "", annotation: nil)
        }

    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        FBSDKAppEvents.activateApp()
    }
    

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        let loginManager: FBSDKLoginManager = FBSDKLoginManager()
        loginManager.logOut()
    }

    func redirectBasedOnLoginStatus() {
        
        if NSUserDefaultsUtils.getAuthToken() != nil {
            redirectToTabView()
        } else {
            redirectToLoginFlow()
        }
    }
    
    func redirectToTabView() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewControllerWithIdentifier("TabBarController") as! UITabBarController
        let vc = storyboard.instantiateViewControllerWithIdentifier("SetLocationViewController") as! SetLocationViewController

        self.window?.rootViewController = vc
    }
    
    func redirectToLoginFlow() {
     
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("LaunchScreenViewController") as! LaunchScreenViewController
        self.window?.rootViewController = vc
        
    }

}

