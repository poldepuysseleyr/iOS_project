//
//  Beer.swift
//  BeerApp
//
//  Created by Pol De Puysseleyr on 20/08/2017.
//  Copyright © 2017 Pol De Puysseleyr. All rights reserved.
//

import Foundation
class Beer {
    let id : Int
    let name : String
    let label : String
    let description : String
    
    init(id : Int, name : String, label : String, description : String) {
        self.id = id
        self.name = name
        self.label = label
        self.description = description
    }
}
