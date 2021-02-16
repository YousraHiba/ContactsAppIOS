//
//  AddContactViewController.swift
//  ContactsApplication
//
//  Created by Hiba on 03/12/2020.
//

import UIKit
import CoreData

class AddContactViewController: UIViewController {
    var titleText = "Add Contact"
    var contact : NSManagedObject? = nil
    var indexPathForContact: IndexPath? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = titleText
        if let contact = self.contact{
            nameTextField.text = contact.value(forKey: "name") as? String
            phoneNumberTextField.text = contact.value(forKey: "phoneNumber") as? String
            emailTextField.text = contact.value(forKey: "email") as? String
            adressTextField.text = contact.value(forKey: "adress") as? String
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var adressTextField: UITextField!
    
    @IBAction func saveAndClose(_ sender: Any) {
        performSegue(withIdentifier : "unwindToContactList", sender :self)
        
    }
    
    
    @IBAction func close(_ sender: Any) {
        
        nameTextField.text = nil
        phoneNumberTextField.text = nil
        emailTextField.text = nil
        adressTextField.text = nil
      
        performSegue(withIdentifier : "unwindToContactList", sender :self)
    }
     
    
    
}
