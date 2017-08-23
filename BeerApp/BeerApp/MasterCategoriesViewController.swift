//
//  MasterViewController.swift
//  BeerApp
//
//  Created by Pol De Puysseleyr on 18/08/2017.
//  Copyright © 2017 Pol De Puysseleyr. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MasterCategoriesViewController: UITableViewController {
    
    private var categories = [Category]()

    /*var detailViewController: DetailViewController? = nil
    var objects = [Any]()*/


    override func viewDidLoad() {
        super.viewDidLoad()
        Service.shared.getCategories{result in
            switch result {
            case .success(let categories) :
                self.categories = categories as! [Category]
                self.tableView.reloadData()
            case .failure(let string):
                let alert = UIAlertController(title: "Error", message: string, preferredStyle: UIAlertControllerStyle.alert)
                let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                
            }
        }

    }

    /*override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }*/

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowStyles" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let categoryIdToPass = categories[indexPath.row].id
                let navigationController = segue.destination as! UINavigationController
                let subCategoriesController = navigationController.topViewController as! StylesViewController
                subCategoriesController.categoryId = categoryIdToPass
            }
        }
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategorieCell", for: indexPath)
        let categorie = self.categories[indexPath.row]
        cell.textLabel?.text = categorie.name
        return cell
    }
    
    @IBAction func unwindToMasterCategoriesViewController(segue: UIStoryboardSegue){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
   

}

