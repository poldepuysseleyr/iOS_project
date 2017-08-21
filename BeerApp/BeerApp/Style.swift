//
//  Style.swift
//  BeerApp
//
//  Created by Pol De Puysseleyr on 20/08/2017.
//  Copyright © 2017 Pol De Puysseleyr. All rights reserved.
//

import Foundation
import SwiftyJSON

class Style{
    let id : Int
    let name : String
    
    init(id : Int, name : String) {
        self.id = id
        self.name = name
    }
    
}

extension Style{
    convenience init? (json : JSON, categoryId : Int){
        
        let styleId = json["id"].intValue
        let categoryIdStyle = json["categoryId"].intValue
        let style = json["name"].stringValue
        if categoryIdStyle == categoryId{
            self.init(id: styleId, name: style)
        }else {
            return nil
        }

    }
}
