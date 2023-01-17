//
//  moneyTableViewCell.swift
//  ConsumableIAPs
//
//  Created by 侯懿玲 on 2023/1/17.
//

import UIKit

class CoinsTableViewCell: UITableViewCell {
    
    static let identifier = "CoinsTableViewCell"
    
    @IBOutlet weak var coinLabel: UILabel!
    @IBOutlet weak var addCoinButton: UIButton!
    
    var delegate: AddCoinProtocol!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func toBuy(_ sender: UIButton) {
        
        switch coinLabel.text {
        case "50":
            IAPManger.shared.purchase(product: .coin_50) { [self] count in
                self.delegate.addCoins(coins: count)
            }
        case "100":
            IAPManger.shared.purchase(product: .coin_100) { [self] count in
                self.delegate.addCoins(coins: count)
            }
        case "500":
            IAPManger.shared.purchase(product: .coin_500) { [self] count in
                self.delegate.addCoins(coins: count)
            }
        case "1000":
            IAPManger.shared.purchase(product: .coin_1000) { [self] count in
                self.delegate.addCoins(coins: count)
            }
        default:
            break
        }
    }
}

protocol AddCoinProtocol {
    func addCoins(coins: Int)
}
