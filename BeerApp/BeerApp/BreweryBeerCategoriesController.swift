//
//  BreweryBeerCategories.swift
//  BeerApp
//
//  Created by Pol De Puysseleyr on 22/08/2017.
//  Copyright © 2017 Pol De Puysseleyr. All rights reserved.
//

import Foundation
import UIKit

class BreweryBeerCategoriesController : UITableViewController {
    
    
    var breweryId : String?
    var beers : [Beer] = []
    var availabilities = [(String,Int)]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Service.shared.getBeersFromBrewery(breweryId: breweryId!){result in
            switch result {
            case .success(let beers) :
                self.beers = beers as! [Beer]
                var availabilitiesHelp : [String] = []
                for beer in self.beers {
                    availabilitiesHelp.append(beer.availability)
                }
                let avavailabilities = Array(Set(availabilitiesHelp))
                for a in avavailabilities {
                    var amount : Int = 0
                    for beer in self.beers {
                        if a == beer.availability{
                            amount += 1
                        }
                        
                    }
                    self.availabilities.append((a,amount))
                }
                self.tableView.reloadData()
            case .failure(let string):
                let alert = UIAlertController(title: "Error", message: string, preferredStyle: UIAlertControllerStyle.alert)
                let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                
            }
            
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowBreweryBeers" {
            if let indexPath = self.tableView.indexPathForSelectedRow{
                let availability = self.availabilities[indexPath.row]
                let beersToPass = self.beers.filter{ $0.availability == availability.0}
                let navigationController = segue.destination as! UINavigationController
                let breweryBeerOverviewController = navigationController.topViewController as! BreweryBeerOverviewController
                breweryBeerOverviewController.beers = beersToPass
            }
            
            
            
        }
    }
    
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availabilities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AvailabilityCell", for: indexPath)
        let availability = self.availabilities[indexPath.row]
        cell.textLabel?.text = availability.0
        cell.detailTextLabel?.text = String(availability.1)
        return cell
    }

    
}
