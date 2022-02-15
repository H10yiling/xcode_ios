//
//  MyCollectionViewCell.swift
//  UITest0214
//
//  Created by Defalt Lee on 2022/2/14.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "MyCollectionViewCell"

    @IBOutlet weak var cellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
