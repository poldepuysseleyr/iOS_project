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
    
    func getCategories(completionHandler : @escaping([Category]) -> Void) -> Void {
        Alamofire.request("https://api.brewerydb.com/v2/categories?" + apikey).responseJSON{ response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")
            
            var categories = [Category]()
            let swiftyJSON = JSON(response.result.value!)
            
            for (_,subJson) in swiftyJSON["data"]{
                categories.append(Category.init(json: subJson))
                /*print("string: \(string)" )*/
            }
            categories.removeLast()
            completionHandler(categories.sorted(by: {$0.name < $1.name }))
            
            
            
            
            
            
        }
    }
    
    func getStyles(categoryId : Int , completionHandler : @escaping([Style]) -> Void) -> Void {
        Alamofire.request("https://api.brewerydb.com/v2/styles?" + apikey).responseJSON{ response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")
            
            var styles = [Style]()
            let swiftyJSON = JSON(response.result.value!)
            
            for (_,subJson) in swiftyJSON["data"]{
                if let style = Style.init(json: subJson, categoryId: categoryId){
                    styles.append(style)
                }
                
            }
            completionHandler(styles.sorted(by: {$0.name < $1.name}))
            
            
            
            
            
        }
    }
    
    func getBeers(style : Style , completionHandler : @escaping([Beer]) -> Void) -> Void {
        let parameters: Parameters = ["styleId": style.id]
        Alamofire.request("https://api.brewerydb.com/v2/beers?" + apikey, method : .get, parameters : parameters).responseJSON{ response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")
            
            var beers = [Beer]()
            let swiftyJSON = JSON(response.result.value!)
            
            for (_,subJson) in swiftyJSON["data"]{
                beers.append(Beer.init(json: subJson))
            }
            completionHandler(beers.sorted(by: {$0.name < $1.name}))
            
            
            
        }
    }
    
    func getBreweryFromBeer(beerId : String, completionHandler : @escaping([Brewery]) -> Void) -> Void {
        Alamofire.request("https://api.brewerydb.com/v2/beer/" + beerId + "/breweries/?" + apikey).responseJSON{ response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")
            
            print(response.result.value!)
            
            var breweries = [Brewery]()
            let swiftyJSON = JSON(response.result.value!)
            
            for (_,subJson) in swiftyJSON["data"]{
                breweries.append(Brewery.init(json: subJson))
            }
            completionHandler(breweries.sorted(by: {$0.name < $1.name}))
            
            
            
            
        }
    }
    
    func getBeersFromBrewery(breweryId : String , completionHandler : @escaping([Beer]) -> Void) -> Void {
        Alamofire.request("https://api.brewerydb.com/v2/brewery/" + breweryId + "/beers?" + apikey).responseJSON{ response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")
            
            var beers = [Beer]()
            let swiftyJSON = JSON(response.result.value!)
            
            for (_,subJson) in swiftyJSON["data"]{
                beers.append(Beer.init(json: subJson))
            }
            completionHandler(beers.sorted(by: {$0.name < $1.name}))
            
            
            
        }
    }
    
    
    func getGuildsFromBrewery(breweryId : String , completionHandler : @escaping([Guild]) -> Void) -> Void {
        Alamofire.request("https://api.brewerydb.com/v2/brewery/" + breweryId + "/guilds?" + apikey).responseJSON{ response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")
            
            var guilds = [Guild]()
            let swiftyJSON = JSON(response.result.value!)
            
            for (_,subJson) in swiftyJSON["data"]{
                guilds.append(Guild.init(json: subJson))
            }
            completionHandler(guilds.sorted(by: {$0.name < $1.name}))
            
            
            
        }
    }
    
    
    
    
}








