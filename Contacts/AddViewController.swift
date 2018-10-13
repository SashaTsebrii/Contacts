//
//  AddViewController.swift
//  Contacts
//
//  Created by Aleksandr Tsebrii on 10/12/18.
//  Copyright © 2018 Aleksandr Tsebrii. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var toolbarView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var idView: CircleView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var streetAddress1Field: UITextField!
    @IBOutlet weak var streetAddress2Field: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var stateField: UITextField!
    @IBOutlet weak var zipCodeField: UITextField!
    @IBOutlet var textFields: [UITextField]!
    
    // MARK: Properties
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Generate random int and color for new contact.
        let intString = String(randomInt(min: 0, max: 1000))
        idLabel.text = intString
        idView.backgroundColor = UIColor.getRandomColor(int: Int(intString)!)
        
        hideKeyboardWhenTappedAround()
        
        // Observe keyboard change.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Remove itself from observer.
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: Actions
    
    @IBAction func tapSaveBarButton(_ sender: UIBarButtonItem) {
        saveDataToCoreData()
    }
    
    @IBAction func tapDoneButton(_ sender: UIButton) {
        view.endEditing(true)
    }
    
    @IBAction func tapPreviousButton(_ sender: UIButton) {
        // FIXME: Add logic.
    }
    
    @IBAction func tapNextButton(_ sender: UIButton) {
        // FIXME: Add logic.
    }
    
    // MARK: Selectors
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
    }
    
    // MARK: Helper func
    
    // Generate random Int.
    func randomInt(min: Int , max: Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
    
    func saveDataToCoreData() {
        let contact = ContactData(context: context)
        contact.contactIDString = idLabel.text
        contact.firstNameString = firstNameField.text
        contact.lastNameString = lastNameField.text
        contact.phoneNumberString = phoneNumberField.text
        contact.streetAddress1String = streetAddress1Field.text
        contact.streetAddress2String = streetAddress2Field.text
        contact.cityString = cityField.text
        contact.stateString = stateField.text
        contact.zipCodeString = zipCodeField.text
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
    }
    
}

// MARK: -
extension AddViewController: UITextFieldDelegate {
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // Setup toolbarView for textField.
        textField.inputAccessoryView = toolbarView
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // Jump to next textField.
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
}

// MARK: -
extension AddViewController: UIScrollViewDelegate {
    
    // MARK: UIScrollViewDelegate
    
}
