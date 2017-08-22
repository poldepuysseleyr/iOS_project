//
//  BreweryGuildController.swift
//  BeerApp
//
//  Created by Pol De Puysseleyr on 22/08/2017.
//  Copyright © 2017 Pol De Puysseleyr. All rights reserved.
//

import Foundation
import UIKit
class BreweryGuildController: UICollectionViewController{
    
    
    
    var guilds: [Guild] = []
    var breweryId : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Service.shared.getGuildsFromBrewery(breweryId: breweryId!){result in
            self.guilds = result
            self.collectionView?.reloadData()
        }
    }
    
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return guilds.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GuildCell", for: indexPath) as! GuildCell
        let guild = self.guilds[indexPath.row]
        if guild.image.isEmpty{
            cell.imageView.image = #imageLiteral(resourceName: "Label_Placeholder")
        }else{
            let url = URL(string: guild.image)!
            cell.imageView.af_setImage(withURL: url)
        }
        
        cell.nameLabel.text = guild.name
        cell.descriptionLabel.text = guild.description
        cell.sizeToFit()
        return cell
    }
    
    
    
    
    
}
