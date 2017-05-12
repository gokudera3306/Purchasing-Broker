//
//  ThirdDataCell.swift
//  Purchasing Broker
//
//  Created by 連翊涵 on 2017/5/10.
//  Copyright © 2017年 Adam Hung. All rights reserved.
//

import UIKit

class ThirdDataCell: UITableViewCell {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productInfo1: UILabel!
    @IBOutlet weak var productInfo2: UILabel!
    @IBOutlet weak var productInfo3: UILabel!
    
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
