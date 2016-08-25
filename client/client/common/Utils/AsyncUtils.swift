//
//  AsyncUtils.swift
//  client
//
//  Created by Anurag Agnihotri on 25/08/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation

class AsyncUtils {
    
    /**
     Method to run a closure/function on the Main Thread.
     
     - parameter closure: Closure to be executed.
     */
    class func runOnMainThread(closure: dispatch_block_t) {
        
        if NSThread.isMainThread() {
            closure()
        } else {
            dispatch_sync(DispatchLevel.Main.dispatchQueue, closure)
        }
        
    }
    
    /**
     Method to run a closure/function on the Background Thread
     
     - parameter closure: Closure to be executed.
     */
    class func runOnBackgroundThread(closure: dispatch_block_t) {
        dispatch_async(DispatchLevel.Background.dispatchQueue, closure)
    }
    
    
    /**
     Method to run a closure/function on the specified Dispatch Level Thread after delay by some seconds.
     
     - parameter seconds:       <#seconds description#>
     - parameter dispatchLevel: <#dispatchLevel description#>
     - parameter closure:       <#closure description#>
     */
    class func runWithDelay(bySeconds seconds: Double, dispatchLevel: DispatchLevel = .Main, closure: dispatch_block_t) {
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(seconds * Double(NSEC_PER_SEC)))
        dispatch_after(dispatchTime, dispatchLevel.dispatchQueue, closure)
    }
}


/*
 * Enum to Define Dispatch Queue Level & Type.
 */
enum DispatchLevel {
    case Main, UserInteractive, UserInitiated, Utility, Background
    
    var dispatchQueue: OS_dispatch_queue {
        switch self {
        case .Main:             return dispatch_get_main_queue()
        case .UserInteractive:  return dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0)
        case .UserInitiated:    return dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)
        case .Utility:          return dispatch_get_global_queue(QOS_CLASS_UTILITY, 0)
        case .Background:       return dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0) }
    }
}
