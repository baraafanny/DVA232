//
//  CustomtableViewCell.swift
//  Lab1_CurrencyConverter
//
//  Created by Louise Bergman on 2017-11-17.
//  Copyright © 2017 Louise Bergman. All rights reserved.
//

import UIKit

class CustomtableViewCell: UITableViewCell {
    
    @IBOutlet weak var Label1: UILabel!
    @IBOutlet weak var Label2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
