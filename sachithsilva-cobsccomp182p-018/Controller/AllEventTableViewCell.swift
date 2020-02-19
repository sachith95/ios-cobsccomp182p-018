//
//  AllEventTableViewCell.swift
//  sachithsilva-cobsccomp182p-018
//
//  Created by Janith Ganewatta on 2/19/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit

class AllEventTableViewCell: UITableViewCell {

    
    @IBOutlet weak var eventImage: UIImageView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var organizerLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
