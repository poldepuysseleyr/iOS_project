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
class BeerViewController : UITableViewController {
    
    @IBOutlet weak var beerName : UILabel!
    @IBOutlet weak var beerDescription : UILabel!
    @IBOutlet weak var imageView : UIImageView!

    
    var beer : Beer?
    
    override func viewDidLoad(){
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100
        
        beerName.text = beer!.name
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
