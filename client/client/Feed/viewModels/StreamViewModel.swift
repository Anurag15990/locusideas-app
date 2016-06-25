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
    
    override init() {
        super.init()
        self.fetchProjects()
    }
    
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
    
    /**
     Method to fetch Project Picture URL.
     
     - parameter project: <#project description#>
     
     - returns: <#return value description#>
     */
    func fetchProjectPictureUrl(project: Project) -> String? {
        if let url = project.medias?.initial?.first?.media?.url {
            return url
        }
        return nil
    }
    
    /**
     Method to fetch Project Title.
     
     - parameter project: <#project description#>
     
     - returns: <#return value description#>
     */
    func fetchProjectTitle(project: Project) -> String? {
        if let title = project.title {
            return title
        }
        return nil
    }
    
    /**
     Method to fetch Project Owner Name.
     
     - parameter project: <#project description#>
     
     - returns: <#return value description#>
     */
    func fetchProjectOwnerName(project: Project) -> String {
        
        var fullName = ""
        
        if let firstName = project.owner?.user?.name?.firstName {
            fullName += firstName + " "
        }
        
        if let lastName = project.owner?.user?.name?.lastName {
            fullName += lastName + " "
        }
        
        return fullName
    }
}