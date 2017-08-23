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
    
    func getCategories(completionHandler : @escaping(BackendResponse) -> Void) -> Void {
        Alamofire.request("https://api.brewerydb.com/v2/categories?" + apikey).validate().responseJSON{ response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")
            
            
            guard response.error == nil else {
                completionHandler(BackendResponse.failure((response.error?.localizedDescription)!))
                return
            }
            
            
            

            switch response.result {
            case .success :
                var categories = [Category]()
                let swiftyJSON = JSON(response.result.value!)
                
                for (_,subJson) in swiftyJSON["data"]{
                    categories.append(Category.init(json: subJson))
                    /*print("string: \(string)" )*/
                }
                categories.removeLast()
                completionHandler(BackendResponse.success(categories.sorted(by: {$0.name < $1.name })))
            case .failure :
                completionHandler(BackendResponse.failure("Something went wrong, try again later"))
                
            }
            
            
            
            
            
            
        }
    }
    
    func getStyles(categoryId : Int , completionHandler : @escaping(BackendResponse) -> Void) -> Void {
        Alamofire.request("https://api.brewerydb.com/v2/styles?" + apikey).validate().responseJSON{ response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")
            
        
            
            guard response.error == nil else {
                completionHandler(BackendResponse.failure((response.error?.localizedDescription)!))
                return
            }
            
            
            switch response.result {
            case .success :
                var styles = [Style]()
                let swiftyJSON = JSON(response.result.value!)
                
                for (_,subJson) in swiftyJSON["data"]{
                    if let style = Style.init(json: subJson, categoryId: categoryId){
                        styles.append(style)
                    }
                    
                }
                completionHandler(BackendResponse.success(styles.sorted(by: {$0.name < $1.name})))
            case .failure :
                completionHandler(BackendResponse.failure("Something went wrong, try again later"))
                
            }

            
            
            
            
            
            
        }
    }
    
    func getBeers(style : Style , completionHandler : @escaping(BackendResponse) -> Void) -> Void {
        let parameters: Parameters = ["styleId": style.id]
        Alamofire.request("https://api.brewerydb.com/v2/beers?" + apikey, method : .get, parameters : parameters).validate().responseJSON{ response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")
            
            guard response.error == nil else {
                completionHandler(BackendResponse.failure((response.error?.localizedDescription)!))
                return
            }
            
            switch response.result {
            case .success :
                var beers = [Beer]()
                let swiftyJSON = JSON(response.result.value!)
                
                for (_,subJson) in swiftyJSON["data"]{
                    beers.append(Beer.init(json: subJson))
                }
                completionHandler(BackendResponse.success(beers.sorted(by: {$0.name < $1.name})))
            case .failure :
                completionHandler(BackendResponse.failure("Something went wrong, try again later"))
                
            }
            
            
            
            
            
        }
    }
    
    func getBreweryFromBeer(beerId : String, completionHandler : @escaping(BackendResponse) -> Void) -> Void {
        Alamofire.request("https://api.brewerydb.com/v2/beer/" + beerId + "/breweries/?" + apikey).validate().responseJSON{ response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")
            
            guard response.error == nil else {
                completionHandler(BackendResponse.failure((response.error?.localizedDescription)!))
                return
            }
            
            switch response.result {
            case .success :
                var breweries = [Brewery]()
                let swiftyJSON = JSON(response.result.value!)
                
                for (_,subJson) in swiftyJSON["data"]{
                    breweries.append(Brewery.init(json: subJson))
                }
                completionHandler(BackendResponse.success(breweries.sorted(by: {$0.name < $1.name})))
            case .failure :
                completionHandler(BackendResponse.failure("Something went wrong, try again later"))
                
            }

            
            
            
            
            
            
            
            
        }
    }
    
    func getBeersFromBrewery(breweryId : String , completionHandler : @escaping(BackendResponse) -> Void) -> Void {
        Alamofire.request("https://api.brewerydb.com/v2/brewery/" + breweryId + "/beers?" + apikey).validate().responseJSON{ response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")
            
            guard response.error == nil else {
                completionHandler(BackendResponse.failure((response.error?.localizedDescription)!))
                return
            }
            
            switch response.result {
            case .success :
                var beers = [Beer]()
                let swiftyJSON = JSON(response.result.value!)
                
                for (_,subJson) in swiftyJSON["data"]{
                    beers.append(Beer.init(json: subJson))
                }
                completionHandler(BackendResponse.success(beers.sorted(by: {$0.name < $1.name})))
            case .failure :
                completionHandler(BackendResponse.failure("Something went wrong, try again later"))
                
            }
            
           
            
            
            
        }
    }
    
    
    func getGuildsFromBrewery(breweryId : String , completionHandler : @escaping(BackendResponse) -> Void) -> Void {
        Alamofire.request("https://api.brewerydb.com/v2/brewery/" + breweryId + "/guilds?" + apikey).validate().responseJSON{ response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")
            
            
            
            guard response.error == nil else {
                completionHandler(BackendResponse.failure((response.error?.localizedDescription)!))
                return
            }
            
            switch response.result {
            case .success :
                var guilds = [Guild]()
                let swiftyJSON = JSON(response.result.value!)
                
                for (_,subJson) in swiftyJSON["data"]{
                    guilds.append(Guild.init(json: subJson))
                }
                completionHandler(BackendResponse.success(guilds.sorted(by: {$0.name < $1.name})))
            case .failure :
                completionHandler(BackendResponse.failure("Something went wrong, try again later"))
                
            }
            
            
            
            
            
        }
    }
    
    
    
    
}








