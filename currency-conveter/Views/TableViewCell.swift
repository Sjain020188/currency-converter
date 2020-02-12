//
//  TableViewCell.swift
//  currency-conveter
//
//  Created by Shruti Jain on 2020/02/07.
//  Copyright © 2020 Shruti Jain. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var FromCurrency: UITextField!
    @IBOutlet weak var FromAmount: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
