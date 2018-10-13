//
//  ListViewController.swift
//  Contacts
//
//  Created by Aleksandr Tsebrii on 10/12/18.
//  Copyright © 2018 Aleksandr Tsebrii. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let userDefaults = UserDefaults.standard
    var contactsArray: [ContactData]?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Save data from JSON to CoreData once.
        if userDefaults.bool(forKey: Constants.kUserDefaultsLoaded) == false {
            dataFromJSON()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadCoreData()
    }
    
     // MARK: Navigation
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.SegueIdentifier.showAddFromList {
            
        } else if segue.identifier == Constants.SegueIdentifier.showDetailsFromList {
            if let detailsViewController = segue.destination as? DetailsViewController {
                detailsViewController.contactData = sender as? ContactData
            }
        }
     }
    
    // MARK: Actions
    
    @IBAction func tapEditBarButton(_ sender: UIBarButtonItem) {
        tableView.isEditing = !tableView.isEditing
    }
    
    @IBAction func tapAddBarButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: Constants.SegueIdentifier.showAddFromList, sender: nil)
    }
    
    // MARK: Helper func.
    
    func dataFromJSON() {
        // Reading local JSON file.
        if let path = Bundle.main.path(forResource: "Contacts", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let contacts = jsonResult["contacts"] as? [[String:Any]] {
                    // Do stuff.
                    print(contacts)
                    for contact in contacts {
                        // Create coreData object.
                        let newContact = ContactData(context: context)
                        newContact.contactIDString = contact["contactID"] as? String
                        newContact.firstNameString = contact["firstName"] as? String
                        newContact.lastNameString = contact["lastName"] as? String
                        newContact.phoneNumberString = contact["phoneNumber"] as? String
                        newContact.streetAddress1String = contact["streetAddress1"] as? String
                        newContact.streetAddress2String = contact["streetAddress2"] as? String
                        newContact.cityString = contact["city"] as? String
                        newContact.stateString = contact["state"] as? String
                        newContact.zipCodeString = contact["zipCode"] as? String
                        (UIApplication.shared.delegate as! AppDelegate).saveContext()
                    }
                    userDefaults.set(true, forKey: Constants.kUserDefaultsLoaded)
                    userDefaults.synchronize()
                }
            } catch let error {
                print("Parse error: \(error.localizedDescription)")
            }
        } else {
            print("Invalid filename/path.")
        }
    }
    
    func loadCoreData()  {
        // Load data from CoreData.
        do {
            let contacts = try context.fetch(ContactData.fetchRequest())
            self.contactsArray = contacts as? [ContactData]
            self.tableView.reloadData()
        } catch {
            print("Fetching failed.")
        }
    }
    
}

// MARK: -
extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let contactsArray = contactsArray {
            return contactsArray.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.listCellIdentifier, for: indexPath) as! ListTableViewCell
        if let contactsArray = contactsArray {
            cell.contactData = contactsArray[indexPath.row]
        }
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let contactsArray = contactsArray {
            let contact = contactsArray[indexPath.row]
            performSegue(withIdentifier: Constants.SegueIdentifier.showDetailsFromList, sender: contact)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let contact = contactsArray![indexPath.row]
        
        if editingStyle == .delete {
            context.delete(contact)
            
            do {
                try context.save()
            } catch let error as NSError {
                print("Error While Deleting Note: \(error.userInfo)")
            }
        }
        loadCoreData()
    }
    
}
