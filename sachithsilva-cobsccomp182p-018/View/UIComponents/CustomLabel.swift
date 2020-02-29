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
        let ipimage = IPImage(text: "Neil Patrick Harris", radius: 30, font: UIFont(name: "Cochin-Italic", size: 30), textColor: nil, randomBackgroundColor: true)
        let attachment: NSTextAttachment = NSTextAttachment()
        attachment.image =  ipimage.generateImage()
        let attachmentString: NSAttributedString = NSAttributedString(attachment: attachment)
        
            let strLabelText: NSMutableAttributedString = NSMutableAttributedString(string: self.text!)
        strLabelText.append(attachmentString)
            
            self.attributedText = strLabelText
        
    }
    
}
