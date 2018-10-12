//
//  ListTableViewCell.swift
//  Contacts
//
//  Created by Aleksandr Tsebrii on 10/12/18.
//  Copyright © 2018 Aleksandr Tsebrii. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    
    @IBOutlet weak var cellView: UIView! {
        didSet {
            cellView.layer.cornerRadius = 4
            cellView.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var idView: CircleView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    // MARK: Properties
    
    var contactData: ContactData?
    
    // MARK: Initialization

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        
        if let contactData = contactData {
            idLabel.text = contactData.contactIDString
            if let firstName = contactData.firstNameString, let lastName = contactData.lastNameString {
                fullNameLabel.text = "\(lastName) \(firstName)"
            }
            phoneNumberLabel.text = contactData.phoneNumberString
            if let idString = contactData.contactIDString {
                idView.backgroundColor = UIColor.getRandomColor(int: Int(idString)!)
            }
        }
    }

}
