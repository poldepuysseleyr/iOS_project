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
            self.categories = result
            self.tableView.reloadData()
        }

    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

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
    
    /*override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "categoryId", sender: self)
    }*/

    /*override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }*/


}

