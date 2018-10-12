//
//  CircleView.swift
//  Contacts
//
//  Created by Aleksandr Tsebrii on 10/12/18.
//  Copyright © 2018 Aleksandr Tsebrii. All rights reserved.
//

import UIKit

class CircleView: UIView {
    
    // MARK: Inirialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialization()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialization()
    }
    
    // MARK: Helper func.
    
    func initialization() {
        layer.cornerRadius = max(frame.height, frame.width) / 2
        layer.masksToBounds = true
    }
    
    
}
