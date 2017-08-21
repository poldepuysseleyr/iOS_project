//
//  BeerViewController.swift
//  BeerApp
//
//  Created by Pol De Puysseleyr on 19/08/2017.
//  Copyright © 2017 Pol De Puysseleyr. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage
import Alamofire
import SwiftyJSON
class BeerViewController : UITableViewController {
    
    @IBOutlet weak var beerName : UILabel!
    @IBOutlet weak var beerABV : UILabel!
    @IBOutlet weak var beerBrewery : UILabel!
    @IBOutlet weak var beerStyle : UILabel!
    @IBOutlet weak var beerAvailability : UILabel!
    @IBOutlet weak var beerDescription : UILabel!
    @IBOutlet weak var imageView : UIImageView!
    
    private let apikey = "key=4626ec2bee6f31163dca9b789a8a76d1"

    
    var beer : Beer?
    
    override func viewDidLoad(){
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100
        
        beerName.text = "Name: \(beer!.name)"
        beerABV.text = "ABV: \(beer!.ABV) %"
        beerBrewery.text = "Brewed by: \(beer!.brewery)"
        beerStyle.text = "Style: \(beer!.style)"
        beerAvailability.text = "Availability: \(beer!.availability)"
        beerDescription.text = beer!.description
        
        
        if beer!.label.isEmpty{
            imageView.image = #imageLiteral(resourceName: "Label_Placeholder")
        }else{
            let url = URL(string: beer!.label)!
            imageView.af_setImage(withURL: url)
        }
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    
    
}
