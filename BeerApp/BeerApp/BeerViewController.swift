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
    

    
    var beer : Beer?
    private var breweries : [Brewery] = []
    
    override func viewDidLoad(){
        
        Service.shared.getBreweryFromBeer(beerId: self.beer!.id!){result in
            switch result {
            case .success(let breweries) :
                self.breweries = breweries as! [Brewery]
                self.beerBrewery.text = "Brewed by: \(self.breweries[0].name)"
            case .failure(let string):
                let alert = UIAlertController(title: "Error", message: string, preferredStyle: UIAlertControllerStyle.alert)
                let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                
            }
            
        }
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100
        
        beerName.text = "Name: \(beer!.name)"
        beerABV.text = "ABV: \(beer!.ABV) %"
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowBrewery"{
            let tabBarViewController = segue.destination as! UITabBarController
            let navBarController1 =  tabBarViewController.viewControllers?[0] as! UINavigationController
            let breweryDetailController = navBarController1.topViewController as! BreweryDetailController
            
            let navBarController2 =  tabBarViewController.viewControllers?[1] as! UINavigationController
            let breweryBeerCategoriesController =  navBarController2.topViewController as! BreweryBeerCategoriesController
            
            let navBarController3 =  tabBarViewController.viewControllers?[2] as! UINavigationController
            let breweryGuildController =  navBarController3.topViewController as! BreweryGuildController
            breweryDetailController.brewery = self.breweries[0]
            breweryBeerCategoriesController.breweryId = self.breweries[0].id
            breweryGuildController.breweryId = self.breweries[0].id
            
        }
    }
    
    
    
    
    
    
    
    
}
