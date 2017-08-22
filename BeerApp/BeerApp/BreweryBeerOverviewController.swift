//
//  BreweryBeerOverviewController.swift
//  BeerApp
//
//  Created by Pol De Puysseleyr on 22/08/2017.
//  Copyright © 2017 Pol De Puysseleyr. All rights reserved.
//

import Foundation
import UIKit
class BreweryBeerOverviewController : UICollectionViewController {
    
    
    
    var beers: [Beer] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowBreweryBeer" {
            if let indexPath = collectionView!.indexPathsForSelectedItems?.first {
                let beerToPass = self.beers[indexPath.row]
                let navigationController = segue.destination as! UINavigationController
                let beerViewController = navigationController.topViewController as! BeerViewController
                beerViewController.beer = beerToPass
                
            }
            
        }
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return beers.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BeerOverviewCell", for: indexPath) as! BeerOverviewCell
        let beer = self.beers[indexPath.row]
        if beer.label.isEmpty{
            cell.imageView.image = #imageLiteral(resourceName: "Label_Placeholder")
        }else{
            let url = URL(string: beer.label)!
            cell.imageView.af_setImage(withURL: url)
        }
        
        cell.nameLabel.text = beer.name
        return cell
    }
    
   
    
}
