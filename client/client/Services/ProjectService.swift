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
    func fetchProjects(successCallback: ((projects: [Project]) -> Void),
                       errorCallback: ((error: NSError) -> Void)) {
        
        Alamofire.request(BaseRouter.ProjectRouteManager(ProjectRouter.GetProjects()))
        .debugLog()
        .responseString { (response) in
            switch response.result {
            case .Success(let value):
                if let projectResponse = Mapper<ProjectResponse>().map(value) {
                    if let projects = projectResponse.projects {
                        successCallback(projects: projects)
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
}