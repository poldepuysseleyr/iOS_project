//
//  Brewery.swift
//  BeerApp
//
//  Created by Pol De Puysseleyr on 21/08/2017.
//  Copyright © 2017 Pol De Puysseleyr. All rights reserved.
//

import Foundation
import SwiftyJSON

class Brewery {
    
    let id : String
    let name : String
    let description : String
    let established : Int
    let image : String
    let website : String
    
    init(id : String, name : String, description : String, established : Int, image : String, website : String){
        self.id = id
        self.name = name
        self.description = description
        self.established = established
        self.image = image
        self.website = website
    }
}

extension Brewery {
    
    convenience init( json:JSON){
        
        var description = "No description available"
        if !json["description"].stringValue.isEmpty{
            description = json["description"].stringValue
        }
        let established = json["established"].intValue
        let id = json["id"].stringValue
        var image = ""
        if !json["images"]["medium"].stringValue.isEmpty{
            image = json["images"]["medium"].stringValue
        }
        let name = json["name"].stringValue
        var website = "No website"
        if !json["website"].stringValue.isEmpty{
            website = json["website"].stringValue
        }
        
        self.init(id : id, name: name, description : description, established : established, image : image, website : website )
        
    }
}

