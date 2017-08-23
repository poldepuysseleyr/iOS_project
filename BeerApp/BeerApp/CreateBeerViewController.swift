//
//  CreateBeerViewController.swift
//  BeerApp
//
//  Created by Pol De Puysseleyr on 23/08/17.
//  Copyright © 2017 Pol De Puysseleyr. All rights reserved.
//

import Foundation
import UIKit

class CreateBeerViewController : UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var nameField : UITextField!
    @IBOutlet weak var descriptionField : UITextField!
    @IBOutlet weak var ABVField : UITextField!
    @IBOutlet weak var yearField : UITextField!
    @IBOutlet weak var styleField : UITextField!
    @IBOutlet weak var Image : UIImageView!
    
    var beer : Beer?
    var selectedImage : UIImage?
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker.delegate = self
        Image.image = #imageLiteral(resourceName: "Label_Placeholder")
    }
    
    @IBAction func getPicture(){
        
        self.imagePicker.sourceType = .photoLibrary
        self.imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.selectedImage = image
        picker.dismiss(animated: true, completion: nil)
        self.Image.image = self.selectedImage
    }


    
    
    
    
    @IBAction func save(){
        if let name = nameField.text , name.characters.count > 1, let description = descriptionField.text, description.characters.count > 1,
            let ABV = ABVField.text, ABV.characters.count > 1, let year = yearField.text, year.characters.count > 1, let style = styleField.text, style.characters.count > 1 {
            if self.selectedImage == nil{
                beer = Beer.init(name: name, style: style, ABV: ABV, availability: "Unknown", label: "", description: description, year : year)
            } else {
                beer = Beer.init(name: name, style: style, ABV: ABV, availability: "Unknown", label: "", description: description, year : year, labelSecondary : self.selectedImage!)
            }
            
            
            performSegue(withIdentifier: "created", sender: self)
        }
    }
    
}

