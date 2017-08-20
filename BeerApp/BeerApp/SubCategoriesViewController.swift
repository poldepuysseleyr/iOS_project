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

class SubCategoriesViewController : UITableViewController{
    
    private let apikey = "key=4626ec2bee6f31163dca9b789a8a76d1"
    private var subCategories: [SubCategory] = []
    var categoryId : Int = 0
    
    func configureView() {
        // Update the user interface for the detail item.
        /*if let detail = detailItem {
         if let label = detailDescriptionLabel {
         label.text = detail.description
         }
         }*/
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Alamofire.request("https://api.brewerydb.com/v2/styles?" + apikey).responseJSON{ response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")
            
            if let json = response.result.value {
                let swiftyJSON = JSON(response.result.value!)
                
                for (_,subJson) in swiftyJSON["data"]{
                    let styleId = subJson["id"].intValue
                    let categoryIdStyle = subJson["categoryId"].intValue
                    let style = subJson["name"].stringValue
                    if categoryIdStyle == self.categoryId {
                        self.subCategories.append(SubCategory.init(id: styleId, name: style))
                    }
                    self.tableView.reloadData()
                    
                    
                }
                
                
                /*print("JSON: \(json)") // serialized json response*/
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
        return subCategories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubCategorieCell", for: indexPath)
        let subCategory = self.subCategories[indexPath.row]
        cell.textLabel?.text = subCategory.name
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowBeerOverview" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let subCategoryIdToPass = self.subCategories[indexPath.row].id
                let navigationController = segue.destination as! UINavigationController
                let beerCollectionViewController = navigationController.topViewController as! BeerCollectionViewController
                beerCollectionViewController.subCategoryId = subCategoryIdToPass
            }
        }
    }

    
}
