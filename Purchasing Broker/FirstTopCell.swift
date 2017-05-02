//
//  FirstTopCell.swift
//  Purchasing Broker
//
//  Created by Adam Hung on 2017/4/24.
//  Copyright © 2017年 Adam Hung. All rights reserved.
//

import UIKit

class FirstTopCell: UITableViewCell {
    
    @IBOutlet weak var startPlace: UIButton!
    @IBOutlet weak var direction: UIButton!
    @IBOutlet weak var destination: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
