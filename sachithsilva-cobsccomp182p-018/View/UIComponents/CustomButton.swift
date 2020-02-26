//
//  CustomButton.swift
//  sachithsilva-cobsccomp182p-018
//
//  Created by Janith Ganewatta on 2/26/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 3
        self.backgroundColor = .clear
        self.layer.borderColor = UIColor.red.cgColor
    }

}
