//
//  MyCollectionViewCell.swift
//  UITest0214
//
//  Created by Defalt Lee on 2022/2/14.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = String(describing: MyCollectionViewCell.self)

    @IBOutlet weak var cellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    static func nib() -> UINib {
        return UINib(nibName: String(describing: MyCollectionViewCell.self), bundle: nil)
    }

}
