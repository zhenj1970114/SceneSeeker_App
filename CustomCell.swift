//
//  CustomCell.swift
//  CandySearch
//
//  Created by Jia Zheng on 7/25/16.
//  Copyright © 2016 Peartree Developers. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    
    @IBOutlet weak var MovieName: UILabel!
    @IBOutlet weak var DirectorName: UILabel!
    @IBOutlet weak var TagName: UILabel!
    @IBOutlet weak var ThumbNail: UIImageView!
    @IBOutlet weak var TimeTag: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

