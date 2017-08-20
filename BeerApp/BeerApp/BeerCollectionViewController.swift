//
//  BeerCollectionViewController.swift
//  BeerApp
//
//  Created by Pol De Puysseleyr on 19/08/2017.
//  Copyright © 2017 Pol De Puysseleyr. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage

class BeerCollectionViewController : UICollectionViewController{
    
    
    var subCategoryId : Int = 0
    private let apikey = "key=4626ec2bee6f31163dca9b789a8a76d1"
    private var beers: [Beer] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let parameters: Parameters = ["styleId": self.subCategoryId]
        // Do any additional setup after loading the view, typically from a nib.
        Alamofire.request("https://api.brewerydb.com/v2/beers?" + apikey, method : .get, parameters : parameters).responseJSON{ response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")
            
            if let json = response.result.value {
                let swiftyJSON = JSON(response.result.value!)
                
                for (_,subJson) in swiftyJSON["data"]{
                    let beerId = subJson["id"].intValue
                    let beerName = subJson["name"].stringValue
                    var beerDescription = "No description available"
                    if !subJson["description"].stringValue.isEmpty {
                        beerDescription = subJson["description"].stringValue
                    }
                    let label = subJson["labels"]
                    print("label: \(label)" )

                    
                    if !subJson["labels"]["medium"].stringValue.isEmpty{
                        let beerLabel = subJson["labels"]["medium"].stringValue
                        self.beers.append(Beer.init(id: beerId, name: beerName, label: beerLabel, description : beerDescription))
                    }else{
                        self.beers.append(Beer.init(id: beerId, name: beerName, label: "", description : beerDescription))
                    }
                    
                    
                    
                    
                    self.collectionView!.reloadData()
                    
                    
                }
                
                
                /*print("JSON: \(json)") // serialized json response*/
            }
            
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowBeer" {
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
        
        
        
        
        /*cell.imageView.backgroundColor = UIColor.black*/
        cell.nameLabel.text = beer.name
        return cell
    }
    
}
