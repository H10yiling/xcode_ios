//
//  MainViewController.swift
//  ConsumableIAPs
//
//  Created by 侯懿玲 on 2023/1/17.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var myMoneyLabel: UILabel!
    @IBOutlet weak var coinsTableView: UITableView!
    
    struct CoinModel{
        let title: String
    }
    
    var coinsArray = [CoinModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myMoneyLabel.text = "\(myMoney)"
        setupCoinsTableViewCell()
        setupCoins()
    }
    
    /// 設定 TableView
    private func setupCoinsTableViewCell() {
        coinsTableView.delegate = self
        coinsTableView.dataSource = self
        coinsTableView.register(
            UINib(nibName: CoinsTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: CoinsTableViewCell.identifier)
    }
    
    private func setupCoins() {
        coinsArray.append(CoinModel(title: "50"))
        coinsArray.append(CoinModel(title: "100"))
        coinsArray.append(CoinModel(title: "500"))
        coinsArray.append(CoinModel(title: "1000"))
    }
    
    var myMoney: Int {
        return UserDefaults.standard.integer(forKey: "coin_count")
    }
    
}
// MARK: - UITableViewDataSource, UITableViewDelegate
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    // UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coinsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinsTableViewCell.identifier,
                                                       for: indexPath) as? CoinsTableViewCell else {
            fatalError("CoinsTableViewCell 載入失敗")
        }
        cell.delegate = self
        cell.coinLabel.text = "\(coinsArray[indexPath.row].title)"
        return cell
    }
}

extension MainViewController: AddCoinProtocol {
    func addCoins(coins: Int) {
        let newCoinsCount = self.myMoney + coins
        UserDefaults.standard.setValue(newCoinsCount, forKey: "coin_count")
        myMoneyLabel.text = "\(myMoney)"
    }
}
