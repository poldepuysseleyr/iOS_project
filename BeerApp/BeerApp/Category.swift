//
//  Category.swift
//  BeerApp
//
//  Created by Pol De Puysseleyr on 20/08/2017.
//  Copyright © 2017 Pol De Puysseleyr. All rights reserved.
//

import Foundation
import SwiftyJSON

class Category{
    let id : Int
    let name : String
    
    init(id : Int, name : String) {
        self.id = id
        self.name = name
    }
    
}

extension Category {
    
    convenience init(json : JSON) {
        
        
        let categoryId = json["id"].intValue
        let categoryName = json["name"].stringValue
        self.init(id: categoryId, name: categoryName)
        
        
        
        
        
    }
    
}
