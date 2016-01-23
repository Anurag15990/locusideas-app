//
//  BaseRouter.swift
//  client
//
//  Created by Anurag Agnihotri on 1/9/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

enum BaseRouter: URLRequestConvertible {
    
    /// Static Endpoint/Base URL being fetched from Info.plist
    static let baseURL = NSBundle.mainBundle().objectForInfoDictionaryKey("BASE_API") as! String
    
    case AuthRouterManager(AuthRouter)
    
    /// URL Request is formed here.
    var URLRequest: NSMutableURLRequest {
        switch self {
       
        case .AuthRouterManager(let request):
            let mutableURLRequest = configureRequest(request)
            return mutableURLRequest
        
        }
    }
    
    /**
     Configuring Request for each of the cases.
     
     - parameter requestObj: An Object of the Router Protocol.
                            - Contains Path of the Request.
                            - Contains Method GET, POST, PUT
                            - Contains Request Parameters
                            - Contains Request Body
     
     - returns: <#return value description#>
     */
    func configureRequest(requestObj: BaseRouterProtocol) -> NSMutableURLRequest {
        
        let url = NSURL(string: BaseRouter.baseURL)!
        
        /// Set Request Path
        let mutableURLRequest = NSMutableURLRequest(URL: url.URLByAppendingPathComponent(requestObj.path))
        
        /**
        *  Set Request Method
        */
        mutableURLRequest.HTTPMethod = requestObj.method.rawValue
        
        
        /**
        *  Set Request Body if Method is POST or PUT
        */
        if requestObj.method == Alamofire.Method.POST || requestObj.method == Alamofire.Method.PUT {
            if let body = requestObj.body {
                mutableURLRequest.HTTPBody = Mapper().toJSONString(body , prettyPrint: false)!.dataUsingEncoding(NSUTF8StringEncoding,allowLossyConversion: false)
            }
        }
        
        //// Set Request Parameters.
        if let parameters: AnyObject = requestObj.parameters {
            return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: parameters as? [String : AnyObject]).0
        }
        
        return mutableURLRequest
    }
}