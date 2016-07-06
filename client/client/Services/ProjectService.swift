//
//  ProjectService.swift
//  client
//
//  Created by Anurag Agnihotri on 6/25/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class ProjectService: NSObject {
    
    
    static let sharedInstance = ProjectService()
    
    /**
     Method to fetch projects.
     
     - parameter successCallback: SuccessCallback that returns Projects array.
     - parameter errorCallback:   ErrorCallback that returns NSError.
     */
    func fetchProjects(successCallback: ((projects: [Project], paging: Pagination?) -> Void),
                       errorCallback: ((error: NSError) -> Void)) {
        
        Alamofire.request(BaseRouter.ProjectRouteManager(ProjectRouter.GetProjects()))
        .debugLog()
        .responseString { (response) in
            switch response.result {
            case .Success(let value):
                if let projectResponse = Mapper<ProjectResponse>().map(value) {
                    if let projects = projectResponse.projects {
                        successCallback(projects: projects, paging: projectResponse.paging)
                    }
                }
                
            case .Failure(let error):
                errorCallback(error: error)
            }
        }
    }
    
    
    /**
     Method to fetch Projects By Given URL.
     
     - parameter url:             <#url description#>
     - parameter successCallback: <#successCallback description#>
     - parameter errorCallback:   <#errorCallback description#>
     */
    func fetchProjectsByURL(url: String,
                            successCallback: ((projects: [Project], paging: Pagination?) -> Void),
                            errorCallback: ((error: NSError) -> Void)) {
        Alamofire.request(BaseRouter.ProjectRouteManager(ProjectRouter.GetProjectsByURL(url)))
        .debugLog()
        .responseString { (response) in
            switch response.result {
            
            case .Success(let value):
                if let projectResponse = Mapper<ProjectResponse>().map(value) {
                    if let projects = projectResponse.projects {
                        successCallback(projects: projects, paging: projectResponse.paging)
                    }
                }
                
            case .Failure(let error):
                errorCallback(error: error)
            }
        }
    }
    
    /**
     Method to fetch Project by Project Id
     
     - parameter projectId:       Id of the Project
     - parameter successCallback: successCallback description
     - parameter errorCallback:   errorCallback description
     */
    func fetchProjectById(projectId: String,
                          successCallback: ((project: Project) -> Void),
                          errorCallback: ((error: NSError) -> Void)) {
        
        Alamofire.request(BaseRouter.ProjectRouteManager(ProjectRouter.GetProjectById(projectId)))
        .debugLog()
        .responseString { (response) in
            switch response.result {
            case .Success(let value):
                if let project = Mapper<Project>().map(value) {
                    successCallback(project: project)
                }
                
            case .Failure(let error):
                errorCallback(error: error)
            }
        }
    }
    
    
    /**
     Method to fetch Project Media By Project Id.
     
     - parameter projectId:       <#projectId description#>
     - parameter successCallback: <#successCallback description#>
     - parameter errorCallback:   <#errorCallback description#>
     */
    func fetchProjectMediaById(projectId: String,
                               successCallback: ((media: ProjectMedia) -> Void),
                               errorCallback: ((error: NSError) -> Void)) {
        
        Alamofire.request(BaseRouter.ProjectRouteManager(ProjectRouter.GetProjectMediaByProjectId(projectId)))
        .debugLog()
        .responseString { (response) in
            switch response.result {
            case .Success(let value):
                if let projectMedia = Mapper<ProjectMedia>().map(value) {
                    successCallback(media: projectMedia)
                }
                
            case .Failure(let error):
                errorCallback(error: error)
            }
        }
    }
}