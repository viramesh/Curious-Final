//
//  KitsTableViewCell.swift
//  Curious
//
//  Created by viramesh on 4/5/15.
//  Copyright (c) 2015 DIY. All rights reserved.
//

import UIKit

class KitsTableViewCell: UITableViewCell {

    @IBOutlet weak var kitImage: UIImageView!
    @IBOutlet weak var kitNameLabel: UILabel!
    @IBOutlet weak var kitQtyLabel: UILabel!
    @IBOutlet weak var kitPriceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
