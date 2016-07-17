//
//  SettingsViewModel.swift
//  client
//
//  Created by Anurag Agnihotri on 16/07/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation
import Bond

class SettingsViewModel: NSObject {
    
    var settingsDataSourceArray = ObservableArray<(String, String)>()
    
    override init() {
        super.init()
        
        settingsDataSourceArray.appendContentsOf(
            [
                ("", "About"),
                ("", "Version"),
                ("", "Terms & Conditions"),
                ("", "Privacy Policy"),
                ("", "Logout")
            ])
    }
}