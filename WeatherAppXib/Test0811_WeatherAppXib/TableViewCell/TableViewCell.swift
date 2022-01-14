//
//  TableViewCell.swift
//  Test0811_WeatherAppXib
//
//  Created by 侯懿玲 on 2021/8/14.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var cityName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        grade = cityName.text! // 使用全域變數作為回傳城市名稱
    }
    
}

