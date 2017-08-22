//
//  Guild.swift
//  BeerApp
//
//  Created by Pol De Puysseleyr on 22/08/2017.
//  Copyright © 2017 Pol De Puysseleyr. All rights reserved.
//

import Foundation
import SwiftyJSON

class Guild {
    
    let name : String
    let description : String
    let image : String
    
    init(name : String, description : String, image : String) {
        self.name = name
        self.description = description
        self.image = image
    }

}

extension Guild {
    
    convenience init(json : JSON){
        
        let description = json["description"].stringValue
        let name = json["name"].stringValue
        var image = ""
        if !json["images"]["medium"].stringValue.isEmpty{
            image = json["images"]["medium"].stringValue
        }
        
        self.init(name: name, description: description, image: image)
    }
}
