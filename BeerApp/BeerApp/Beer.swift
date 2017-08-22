//
//  Beer.swift
//  BeerApp
//
//  Created by Pol De Puysseleyr on 20/08/2017.
//  Copyright © 2017 Pol De Puysseleyr. All rights reserved.
//

import Foundation
import SwiftyJSON
class Beer {
    let id : String
    let name : String
    let style : String
    let ABV : String
    let availability : String
    let label : String
    let description : String
    
    
    init(id : String, name : String, style : String, ABV : String, availability : String,label : String, description : String) {
        self.id = id
        self.name = name
        self.style = style
        self.ABV = ABV
        self.availability = availability
        self.label = label
        self.description = description
    }
    
    
    
    
}

extension Beer {
    
    convenience init(json : JSON){
        let beerId = json["id"].stringValue
        let beerName = json["name"].stringValue
        let beerStyle = json["style"]["name"].stringValue
        let beerABV = json["abv"].stringValue
        var beerAvailability = "Unknown"
        if !json["available"]["name"].stringValue.isEmpty {
            beerAvailability = json["available"]["name"].stringValue
        }
        var beerDescription = "No description available"
        if !json["description"].stringValue.isEmpty {
            beerDescription = json["description"].stringValue
        }
        
        if !json["labels"]["medium"].stringValue.isEmpty{
            let beerLabel = json["labels"]["medium"].stringValue
            self.init(id: beerId, name: beerName, style : beerStyle, ABV: beerABV, availability : beerAvailability, label: beerLabel, description : beerDescription)
        }else{
            self.init(id: beerId, name: beerName, style : beerStyle, ABV: beerABV, availability : beerAvailability, label: "", description : beerDescription)
        }
    }
}
