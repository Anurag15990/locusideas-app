//
//  UserRouter.swift
//  client
//
//  Created by Anurag Agnihotri on 3/20/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation
import Alamofire

enum UserRouter: BaseRouterProtocol {
 
    case GetMeRequest()
    case FollowUserRequest(UserFollowRequestBody)
    case UnfollowUserRequest(UserUnfollowRequestBody)
    case UpdateUserRequest(String, User)
    case GetUser(String)
    case GetUsers()
    case GetDesigners()
    case GetDesignersByURL(String)
    case OnboardUser(String, UserOnboardingRequestBody)
    
    var baseURL: String {
        switch  self {
        
        case .GetDesignersByURL(let url):
            return url
        
        default:
            return BaseRouter.baseURL
        
        }
    }
    
    var path: String {
        
        switch self {
        
        case .GetMeRequest():
            return "/api/users/me"
            
        case .FollowUserRequest:
            return "/api/users/follow"
        
        case .UnfollowUserRequest:
            return "/api/users/unfollow"
            
        case .UpdateUserRequest(let userId, _):
            return "/api/users/\(userId)"
            
        case .GetUser(let userId):
            return "/api/users/\(userId)"
            
        case .GetUsers:
            return "/api/users"
            
        case .GetDesigners:
            return "/api/users/designers"
            
        case .GetDesignersByURL:
            return ""
            
        case .OnboardUser(let userId, _):
            return "/api/users/\(userId)/onboarding"
        }
    
    }
    
    var method: Alamofire.Method {
    
        switch self {
        
        case .GetMeRequest:
            return .GET
            
        case .FollowUserRequest:
            return .POST
            
        case .UnfollowUserRequest:
            return .POST
            
        case .UpdateUserRequest:
            return .PUT
            
        case .GetUser:
            return .GET
            
        case .GetUsers:
            return .GET
            
        case .GetDesigners:
            return .GET
            
        case .GetDesignersByURL:
            return .GET
            
        case .OnboardUser:
            return .POST
            
        }
    
    }
    
    var parameters: AnyObject? {
        
        switch self {
        
        default:
            return nil
        
        }
    
    }
    
    var body: BaseRequestBody? {
        switch self {
        
        case .FollowUserRequest(let request):
            return request
            
        case .UnfollowUserRequest(let request):
            return request

        case .UpdateUserRequest(_, let request):
            return request
            
        case .OnboardUser(_, let request):
            return request
            
        default:
            return BaseRequestBody()
        }
    }
}