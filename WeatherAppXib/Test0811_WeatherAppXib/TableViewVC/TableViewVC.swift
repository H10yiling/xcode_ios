//
//  TableViewVC.swift
//  Test0811_WeatherAppXib
//
//  Created by 侯懿玲 on 2021/8/14.
//

import UIKit
struct Citys {
    var taiwanCityName: String
}

class TableViewVC: UIViewController {
    
    @IBOutlet weak var cityTableView: UITableView!
    
    var cityitem = [
        Citys(taiwanCityName: "宜蘭縣"),Citys(taiwanCityName: "花蓮縣"),
        Citys(taiwanCityName: "臺東縣"),Citys(taiwanCityName: "澎湖縣"),
        Citys(taiwanCityName: "金門縣"),Citys(taiwanCityName: "連江縣"),
        Citys(taiwanCityName: "臺北市"),Citys(taiwanCityName: "新北市"),
        Citys(taiwanCityName: "桃園市"),Citys(taiwanCityName: "臺中市"),
        Citys(taiwanCityName: "臺南市"),Citys(taiwanCityName: "高雄市"),
        Citys(taiwanCityName: "基隆市"),Citys(taiwanCityName: "新竹縣"),
        Citys(taiwanCityName: "新竹市"),Citys(taiwanCityName: "苗栗縣"),
        Citys(taiwanCityName: "彰化縣"),Citys(taiwanCityName: "南投縣"),
        Citys(taiwanCityName: "雲林縣"),Citys(taiwanCityName: "嘉義縣"),
        Citys(taiwanCityName: "嘉義市"),Citys(taiwanCityName: "屏東縣")
    ]
    
    var delegate: TableViewVCprotocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityTableView.delegate = self
        cityTableView.dataSource = self
        // TableView進行轉向的動作
        self.cityTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cityCell")
    }
}

@objc protocol TableViewVCprotocol {

    @objc func getWeatherData(locationName:String)

}

// MARK: - Table view data source
extension TableViewVC: UITableViewDelegate,UITableViewDataSource{
    // tableView要顯示幾列
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cityitem.count
    }
    // cell裏面要顯示什麼
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //我們要將dequeueReuseableCell 參照到剛剛建立的 cell 所以要 Downcasting (向下轉型) ::: as! TableViewCell :::
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as! TableViewCell
        // Cell contents setting
        let city = cityitem[indexPath.row]
        cell.cityName.text = city.taiwanCityName
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    
    
// MARK: - 使用者點選了TableView的第幾列
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("使用者點選了第 \(indexPath.row)項,grade＝ \(grade)")
        // 跳回MainVC
        self.navigationController?.popViewController(animated: true)
        delegate.getWeatherData(locationName: grade)
    }

}
