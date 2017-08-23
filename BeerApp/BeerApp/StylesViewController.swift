//
//  SubCategoriesViewController.swift
//  BeerApp
//
//  Created by Pol De Puysseleyr on 19/08/2017.
//  Copyright © 2017 Pol De Puysseleyr. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class StylesViewController : UITableViewController{
    
    
    private var styles: [Style] = []
    var categoryId : Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Service.shared.getStyles(categoryId: categoryId){result in
            switch result {
            case .success(let styles) :
                self.styles = styles as! [Style]
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
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return styles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StyleCell", for: indexPath)
        let subCategory = self.styles[indexPath.row]
        cell.textLabel?.text = subCategory.name
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowBeerOverview" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let styleToPass = self.styles[indexPath.row]
                let navigationController = segue.destination as! UINavigationController
                let beerCollectionViewController = navigationController.topViewController as! BeerCollectionViewController
                beerCollectionViewController.style = styleToPass
            }
        }
    }
    
    

    
}
