//
//  Service.swift
//  BeerApp
//
//  Created by Pol De Puysseleyr on 19/08/2017.
//  Copyright © 2017 Pol De Puysseleyr. All rights reserved.
//

import Foundation

import UIKit
import Alamofire
import SwiftyJSON

class Service{
    
    private let apikey = "key=4626ec2bee6f31163dca9b789a8a76d1"
    
    static let shared = Service()
    
    func getCategories(completionHandler : @escaping([Category]) -> Void) -> () {
        Alamofire.request("https://api.brewerydb.com/v2/categories?" + apikey).responseJSON{ response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")
            
            var categories = [Category]()
            let swiftyJSON = JSON(response.result.value!)
            
            for (_,subJson) in swiftyJSON["data"]{
                 categories.append(Category.init(json: subJson
                 ))
                /*print("string: \(string)" )*/
            }
            completionHandler(categories)
            
           
            
                /* print("JSON: \(json)") // serialized json response*/
        
            
            
        }
    }
    
    /*func loadUser(completionHandler: @escaping (DataResponse<User>) -> Void) -> Alamofire.DataRequest {
        return Alamofire.request("https://example.com/users/mattt").responseJSON { response in
            let userResponse = response.flatMap { json in
                try User(json: json)
            }
            
            completionHandler(userResponse)
        }
    }*/
    
    
        
    
    
}








