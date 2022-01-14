//
//  MyTableViewCell.swift
//  Test0713
//
//  Created by 侯懿玲 on 2021/7/13.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    
    @IBOutlet var ptView: UIImageView!
    @IBOutlet var date: UILabel!
    @IBOutlet var name: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
