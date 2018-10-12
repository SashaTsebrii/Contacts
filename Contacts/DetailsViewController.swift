//
//  DetailsViewController.swift
//  Contacts
//
//  Created by Aleksandr Tsebrii on 10/12/18.
//  Copyright © 2018 Aleksandr Tsebrii. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var idView: CircleView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var streetAddress1Label: UILabel!
    @IBOutlet weak var streetAddress2Label: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var zipCodeLabel: UILabel!
    
    // MARK: Properties
    
    var contactData: ContactData?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
    }
    
    // MARK: Helper func.
    
    private func setupData() {
        if let contactData = contactData {
            if let idString = contactData.contactIDString {
                idView.backgroundColor = UIColor.getRandomColor(int: Int(idString)!)
            }
            idLabel.text = contactData.contactIDString
            if let firstName = contactData.firstNameString, let lastName = contactData.lastNameString {
                fullNameLabel.text = "\(lastName) \(firstName)"
            }
            phoneNumberLabel.text = contactData.phoneNumberString
            streetAddress1Label.text = contactData.streetAddress1String
            streetAddress2Label.text = contactData.streetAddress2String
            cityLabel.text = contactData.cityString
            stateLabel.text = contactData.stateString
            zipCodeLabel.text = contactData.zipCodeString
        }
    }
    
}
