//
//  ProjectCell.swift
//  Curious
//
//  Created by viramesh on 3/26/15.
//  Copyright (c) 2015 DIY. All rights reserved.
//

import UIKit

class ProjectCell: UITableViewCell {

    @IBOutlet weak var projectImageView: UIImageView!
    @IBOutlet weak var mask: UIView!
    @IBOutlet weak var projectLabel: UILabel!
    @IBOutlet weak var projectSubLabel: UILabel!
    
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
