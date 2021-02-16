//
//OUILI Yousra Hiba
//Zouaoui Sarah
//  ContactsViewController.swift
//  ContactsApplication
//
//  Created by Hiba on 03/12/2020.
//

import UIKit
import CoreData
class ContactsViewController: UITableViewController {
    var contacts : [NSManagedObject] = [] // import Coredata
    
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    // MARK: - Table view data source
    
    
    func fetch(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Contact")
        do{
            contacts = try managedObjectContext.fetch(fetchRequest) as![NSManagedObject]
        }catch let error as NSError{
            print("EROOR !!!!. \(error)")
        }
    }
    
    
    func save(name: String, phoneNumber: String, email: String,adress:String){
        

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate  else {return}
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "Contact", in: managedObjectContext) else{return}
        let contact = NSManagedObject(entity: entity, insertInto: managedObjectContext)
        contact.setValue(name, forKey: "name")
        contact.setValue(phoneNumber, forKey: "phoneNumber")
        contact.setValue(email, forKey: "email")
        contact.setValue(adress, forKey: "adress")


        do{
            try managedObjectContext.save()
            self.contacts.append(contact)
        } catch let error as NSError{
            print("Saving Error . \(error)")
        }
        tableView.reloadData()

        
    }
    func update(indexPath: IndexPath,name: String , phoneNumber:String, email: String,adress:String){
     
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate  else {return}
  
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let contact = contacts[indexPath.row]
        
       

        contact.setValue(name, forKey: "name")
        contact.setValue(phoneNumber, forKey: "phoneNumber")
        contact.setValue(email, forKey: "email")
        contact.setValue(adress, forKey: "adress")
        tableView.reloadData()
        

        do{
            contacts.remove(at: indexPath.row)
            try managedObjectContext.save()
            self.contacts.insert(contact, at: indexPath.row)
        } catch let error as NSError{
            print("UpDate Error . \(error)")
        }

        
    }
    
    func delete(_  contact:NSManagedObject, at indexPath: IndexPath ){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate  else {return}
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        do{
            try managedObjectContext.delete(contact)
            contacts.remove(at: indexPath.row)
            tableView.reloadData()

        } catch let error as NSError{
            print("Deleting Error . \(error)")
        }
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
        let contact = contacts[indexPath.row]
        cell.textLabel?.text = contact.value(forKey: "name") as? String
        cell.detailTextLabel?.text = contact.value(forKey: "phoneNumber") as? String
        return cell
    }

    //Unwind Segue
    
    @IBAction func unwindToContactList(segue : UIStoryboardSegue){
        if  let viewController = segue.source as? AddContactViewController{
        guard let name = viewController.nameTextField.text ,let phoneNumber = viewController.phoneNumberTextField.text,let email = viewController.emailTextField.text ,
              let adress = viewController.adressTextField.text
        else {return}
            if name != "" && phoneNumber != "" && email != "" && adress != ""{
            if let indexPath = viewController.indexPathForContact{
                update(indexPath: indexPath, name: name, phoneNumber: phoneNumber, email: email, adress:adress)
            } else{

                save(name: name, phoneNumber: phoneNumber, email: email,adress:adress)
                tableView.reloadData()
        }
        }
    }
    
        else if let viewController = segue.source as? ContactDetailViewController {
            if viewController.isDeleted {
                guard let indexPath  :IndexPath = viewController.indexPath else {return}
                let contact = contacts[indexPath.row]
                delete(contact,at: indexPath)
                tableView.reloadData()
            
            }
        }
    }
    
    
  
    override func prepare(for segue : UIStoryboardSegue, sender: Any?){
        if segue.identifier == "contactDetailSegue"{
            guard let navViewController = segue.destination as? UINavigationController else {
                return
            }
            guard let viewController = navViewController.topViewController as? ContactDetailViewController else {return }
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let contact = contacts[indexPath.row]
            viewController.contact = contact
            viewController.indexPath = indexPath
            
        }
    }
    
  
}
