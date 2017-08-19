//
//  DetailViewController.swift
//  BeerApp
//
//  Created by Pol De Puysseleyr on 18/08/2017.
//  Copyright © 2017 Pol De Puysseleyr. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!


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
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

        
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSubCategories" {
                let controller = (segue.destination as! UINavigationController).topViewController as! SubcategoriesViewController
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            
        }
    }*/
    
        
    


}

