//
//  Beer.swift
//  BeerApp
//
//  Created by Pol De Puysseleyr on 20/08/2017.
//  Copyright © 2017 Pol De Puysseleyr. All rights reserved.
//

import Foundation
class Beer {
    let id : String
    let name : String
    let style : String
    let ABV : String
    let availability : String
    let brewery : String
    let label : String
    let description : String
    
    
    init(id : String, name : String, style : String, ABV : String, availability : String, brewery : String, label : String, description : String) {
        self.id = id
        self.name = name
        self.style = style
        self.ABV = ABV
        self.availability = availability
        self.brewery = brewery
        self.label = label
        self.description = description
    }
}
