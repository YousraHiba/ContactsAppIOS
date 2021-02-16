// 
//  ContactDetailViewController.swift
//  ContactsTest
//
//  Created by Hiba on 03/12/2020.
//

import UIKit
import CoreData
class ContactDetailViewController: UIViewController {
    var contact : NSManagedObject? = nil
    var isDeleted : Bool = false
    var indexPath: IndexPath? = nil

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // nameLabel.text = contact?.name
        
      //  phoneLabel.text = contact?.phoneNumber
        nameLabel.text = contact?.value(forKey: "name") as? String
        phoneLabel.text = contact?.value(forKey: "phoneNumber") as? String

        emailLabel.text = contact?.value(forKey: "email") as? String
        adressLabel.text = contact?.value(forKey: "adress") as? String

        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    
   
    @IBOutlet weak var emailLabel: UILabel!
    
    
    @IBOutlet weak var adressLabel: UILabel!
    
    @IBAction func done(_ sender: Any) {
        
        performSegue(withIdentifier: "unwindToContactList", sender: self)
    }
      
  
    @IBAction func deleteContact(_ sender: Any) {
        isDeleted = true
        performSegue(withIdentifier: "unwindToContactList", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender : Any?){
        if segue.identifier == "editContact"{
            guard let viewController = segue.destination as? AddContactViewController else { return}
            viewController.titleText = "Edit Contact"
            viewController.contact = contact
            viewController.indexPathForContact = self.indexPath
            
            }
            
        }
    }
    

