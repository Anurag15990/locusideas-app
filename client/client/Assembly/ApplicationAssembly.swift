//
//  ApplicationAssembly.swift
//  client
//
//  Created by Anurag Agnihotri on 5/27/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation
import Typhoon

public class ApplicationAssembly: TyphoonAssembly {
    
    /**
     Method to Inject AppDelegate through Typhoon
     
     - returns: <#return value description#>
     */
    
    public dynamic func appDelegate() -> AnyObject {
        return TyphoonDefinition.withClass(AppDelegate.self)
    }
    
}