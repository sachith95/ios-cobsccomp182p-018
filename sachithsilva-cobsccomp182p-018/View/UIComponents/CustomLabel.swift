//
//  CustomLabel.swift
//  sachithsilva-cobsccomp182p-018
//
//  Created by Sachith Silva on 2/28/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit
import IPImage

class CustomLabel: UILabel {
    
    override func draw(_ rect: CGRect) {
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.layer.borderWidth = 3.0
        
    }
    
}
