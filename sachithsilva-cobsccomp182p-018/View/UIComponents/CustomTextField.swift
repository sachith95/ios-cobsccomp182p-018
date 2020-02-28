//
//  CustomTextField.swift
//  sachithsilva-cobsccomp182p-018
//
//  Created by Sachith Silva on 2/26/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {

    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.backgroundColor = .clear
        self.layer.borderColor = UIColor(white: 2/3, alpha: 0.5).cgColor
        self.font = UIFont(name: "Verdana", size: 14)
    }

}
