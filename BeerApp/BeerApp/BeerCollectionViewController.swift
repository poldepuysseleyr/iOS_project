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
    
    
    var style : Style?
    private var beers: [Beer] = []
    private var mustBeHidden = true
    private var switchHidden = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Service.shared.getBeers(style: style!){result in
            switch result {
            case .success(let beers) :
                self.beers = beers as! [Beer]
                self.collectionView!.reloadData()
            case .failure(let string):
                let alert = UIAlertController(title: "Error", message: string, preferredStyle: UIAlertControllerStyle.alert)
                let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                
            }
            
        }
    }
    
    @IBAction func setButtonsVisible(){
        if switchHidden {
            self.mustBeHidden = false
            self.switchHidden = false
            self.collectionView?.reloadData()
            
        }else {
            self.mustBeHidden = true
            self.switchHidden = true
            self.collectionView?.reloadData()
        }
    }
    
    
    @IBAction func unwindFromCreate(_ segue: UIStoryboardSegue) {
        let source = segue.source as! CreateBeerViewController
        if let beer = source.beer {
            self.beers.insert(beer, at: 0)
            collectionView?.insertItems(at: [IndexPath(row: 0, section: 0)])
            self.collectionView?.reloadData()
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !self.mustBeHidden {
            self.beers.remove(at: indexPath.row)
            self.collectionView?.deleteItems(at: [indexPath])
        }else{
            performSegue(withIdentifier: "ShowBeer", sender: self)
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
        if beer.labelSecondary != nil {
            cell.imageView.image = beer.labelSecondary!
        }
        else if beer.label.isEmpty{
            cell.imageView.image = #imageLiteral(resourceName: "Label_Placeholder")
        }else{
            let url = URL(string: beer.label)!
            cell.imageView.af_setImage(withURL: url)
        }
        if mustBeHidden {
            cell.deleteButton.isHidden = true
        } else {
            cell.deleteButton.isHidden = false
        }
        
        
        
        
        /*cell.imageView.backgroundColor = UIColor.black*/
        cell.nameLabel.text = beer.name
        return cell
    }
    
    
    
    
    
    
    
}
