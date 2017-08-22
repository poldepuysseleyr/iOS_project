//
//  BreweryTabController.swift
//  BeerApp
//
//  Created by Pol De Puysseleyr on 21/08/2017.
//  Copyright © 2017 Pol De Puysseleyr. All rights reserved.
//

import Foundation
import AlamofireImage
class BreweryDetailController : UITableViewController {
    
    @IBOutlet weak var breweryName : UILabel!
    @IBOutlet weak var breweryDescription : UILabel!
    @IBOutlet weak var breweryEstablished : UILabel!
    @IBOutlet weak var breweryWebsite : UILabel!
    @IBOutlet weak var breweryImage : UIImageView!
    
    var brewery : Brewery?
    
    override func viewDidLoad() {
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100
        
        
        if brewery!.image.isEmpty{
            breweryImage.image = #imageLiteral(resourceName: "Brewery_Placeholder")
        }else{
            let url = URL(string: brewery!.image)!
            breweryImage.af_setImage(withURL: url)
        }
        breweryName.text = brewery!.name
        breweryDescription.text = brewery!.description
        breweryEstablished.text = "Established in: \(String(brewery!.established))"
        breweryWebsite.text = "Website: \(brewery!.website)"
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    
    
}
