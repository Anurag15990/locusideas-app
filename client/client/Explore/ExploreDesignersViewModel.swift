//
//  ExploreDesignersViewModel.swift
//  client
//
//  Created by Anurag Agnihotri on 6/27/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation
import Bond

class ExploreDesignersViewModel: NSObject {
    
    var designersObservableArray = ObservableArray<User>()
    
    override init() {
        super.init()
    }
    
    
}