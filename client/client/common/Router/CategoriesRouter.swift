//
//  CategoriesRouter.swift
//  client
//
//  Created by Anurag Agnihotri on 19/08/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation
import Alamofire

enum CategoriesRouter: BaseRouterProtocol {
    
    case GetCategories()
    case GetCategory(String)
    case CreateCategory(CategoriesRequest)
    case UpdateCategory(String, CategoriesRequest)
    
    var baseURL: String {
        switch self {
            
        default:
            return BaseRouter.baseURL
        
        }
    }
    
    var path: String {
        
        switch self {
        
        case .GetCategories:
            return "/api/categories"
        
        case .GetCategory(let categoryId):
            return "/api/categories/\(categoryId)"
        
        case .CreateCategory:
            return "/api/categories"
            
        case .UpdateCategory(let categoryId, _):
            return "/api/categories/\(categoryId)"
            
        }
    }
    
    var method: Alamofire.Method {
        
        switch self {
            
        case .GetCategories:
            return .GET
        
        case .GetCategory:
            return .GET
        
        case .CreateCategory:
            return .POST
            
        case .UpdateCategory:
            return .PUT
            
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
            
        case .CreateCategory(let request):
            return request
            
        case .UpdateCategory(_, let request):
            return request
            
        default:
            return nil
            
        }
    }
}