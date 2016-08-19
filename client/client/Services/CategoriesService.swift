//
//  CategoriesService.swift
//  client
//
//  Created by Anurag Agnihotri on 20/08/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class CategoriesService: NSObject {
    
    /**
     Method to fetch list of Categories.
     
     - parameter successCallback: <#successCallback description#>
     - parameter errorCallback:   <#errorCallback description#>
     */
    func fetchCategories(successCallback: ((categories: [Category]) -> Void),
                         errorCallback: ((error: NSError) -> Void)) {
        
        Alamofire.request(BaseRouter.CategoriesRouteManager(CategoriesRouter.GetCategories()))
        .debugLog()
        .responseString { (response) in
            switch response.result {
                
            case .Success(let value):
                let categoriesResponse = Mapper<CategoriesResponse>().map(value)
                if let categories = categoriesResponse?.categories {
                    successCallback(categories: categories)
                }
                
            case .Failure(let error):
                errorCallback(error: error)
            
            }
        }
    }
    
    /**
     Method to fetch a single Category by Id.
     
     - parameter categoryId:      <#categoryId description#>
     - parameter successCallback: <#successCallback description#>
     - parameter errorCallback:   <#errorCallback description#>
     */
    func fetchCategory(categoryId: String,
                       successCallback: ((category: Category) -> Void),
                       errorCallback: ((error: NSError) -> Void)) {
        
        Alamofire.request(BaseRouter.CategoriesRouteManager(CategoriesRouter.GetCategory(categoryId)))
        .debugLog()
        .responseString { (response) in
            switch response.result {
                
            case .Success(let value):
                
                if let category = Mapper<Category>().map(value) {
                    successCallback(category: category)
                }
                
            case .Failure(let error):
                errorCallback(error: error)
            
            }
        }
    }
}