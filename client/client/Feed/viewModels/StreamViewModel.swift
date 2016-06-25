//
//  StreamViewModel.swift
//  client
//
//  Created by Anurag Agnihotri on 6/25/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation
import Bond

class StreamViewModel: NSObject {
    
    var streamArrayObservable = ObservableArray<Project>()
    var errorMessage = Observable<String>("")
    
    /**
     Method to fetch Projects.
     */
    func fetchProjects() {
        ProjectService.sharedInstance.fetchProjects(
            { (projects) in
                
                self.streamArrayObservable.removeAll()
                self.streamArrayObservable.appendContentsOf(projects)
            
            }) { (error) in
                self.errorMessage.next(error.localizedDescription)
        }
    }
}