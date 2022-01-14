//
//  MainVC.swift
//  Test0811_WeatherAppXib
//
//  Created by 侯懿玲 on 2021/8/11.
//

import UIKit
import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
// 目前用全域變數來回傳Cell城市選單
var grade = ""

class MainVC: UIViewController {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var endTime: UILabel!
    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var pop: UILabel!
    @IBOutlet weak var maxT: UILabel!
    @IBOutlet weak var minT: UILabel!
    @IBOutlet weak var wx: UILabel!
    @IBOutlet weak var otherCitys: UIButton!
// MARK: - var
    var authorization = "CWB-947F44DD-8419-4325-B916-47FCB530D292" // 會員碼
//    var selectName = grade
    var selectTime = 0 // 選取器選擇的時間區間，範圍 0~2
    var timeData = ["","",""] // 讀取 JSON 後，存放三個時間的 startTime
    let timePickerView = UIPickerView(frame: CGRect(x: 0, y: 50, width: 270, height: 150)) // 把時間選取器放入提示框裡，大小要自己嘗試調整
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        super.viewDidLoad()
        
        getWeatherData(locationName:grade) // 進入畫面前先讀一次 JSON
        
        // 按一下收起navigationBar
        self.navigationController?.hidesBarsOnTap = true
        
//        timePickerView.dataSource = self
//        timePickerView.delegate = self

    }

// MARK: - 用push轉畫面
    @IBAction func allCitys(_ sender: UIButton) {
        // 告訴他下一個目的地是TableViewVC
        let toTableViewVC = TableViewVC()
        toTableViewVC.delegate = self
        self.navigationController?.pushViewController(toTableViewVC, animated: true)
        
    }
// MARK: - 透過JSON抓取OpenWeatherMap的天氣資訊
    func getWeatherData(locationName:String) {
        let oldurl =  "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-C0032-001?Authorization=\(authorization)&format=JSON&locationName=\(locationName)"
        let newUrl = oldurl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! // 網址有中文，需要先編碼
        var request = URLRequest(url: URL(string: newUrl)!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { [self] data, response, error in
            let decoder = JSONDecoder()
            if let data = data, let weather = try? decoder.decode(Weather.self, from: data){
                print(weather)
                // 顯示在主畫面Lable上的資訊
                DispatchQueue.main.sync {
                    // 顯示地名
                    self.locationName.text = weather.records.location[0].locationName
                    // 降雨機率
                    self.pop.text = weather.records.location[0].weatherElement[1].time[0].parameter.parameterName + "%"
                    // 最低溫度
                    self.minT.text = weather.records.location[0].weatherElement[2].time[0].parameter.parameterName + "°" + weather.records.location[0].weatherElement[2].time[0].parameter.parameterUnit!
                    // 最高溫度
                    self.maxT.text = weather.records.location[0].weatherElement[4].time[0].parameter.parameterName + "°" + weather.records.location[0].weatherElement[4].time[0].parameter.parameterUnit!
                    // 舒適度
                    self.wx.text = weather.records.location[0].weatherElement[0].time[0].parameter.parameterName
                    // 背景依據舒適度而改變
                    self.descriptionToImage()
                    // 選擇器的時間區間start和end
                    self.startTime.text = weather.records.location[0].weatherElement[0].time[0].startTime
                    self.endTime.text = weather.records.location[0].weatherElement[0].time[0].endTime
                    // 把三個 startTime 放入陣列
                    for i in 0...2 {
                        self.timeData[i] = weather.records.location[0].weatherElement[0].time[i].startTime
                    }
                }
            }
            else {print("error")}
        }
        task.resume()
    }
// MARK: - 設定英文描述轉中文，還有搭配適合的weather Icon
    func descriptionToImage () {
        if wx.text!.contains("雨") {
            if wx.text!.contains("雷") { backgroundImage.image = UIImage(named: "rain1") }
            else if wx.text!.contains("晴") { backgroundImage.image = UIImage(named: "rain2") }
            else { backgroundImage.image = UIImage(named: "rain3") }
        }
        else if wx.text!.contains("晴") {
            if wx.text!.contains("雲") { backgroundImage.image = UIImage(named: "sunnycloud1") }
            else { backgroundImage.image = UIImage(named: "sunnycloud2") }
        }
        else if wx.text!.contains("陰") { backgroundImage.image = UIImage(named: "cloud") }
        else if wx.text!.contains("雲") { backgroundImage.image = UIImage(named: "cloudsunny") }
    }
// MARK: - timeView()
//    func timeView() {
//            let alertView = UIAlertController(
//                title: "選擇時間",
//                message: "\n\n\n\n\n\n\n\n\n", // 因為要放入選取器，使提示框高度增高
//                preferredStyle: .alert
//            )
//            let cancelAction = UIAlertAction(
//                title: "取消",
//                style: .default,
//                handler: nil
//            )
//
//            let okAction = UIAlertAction(
//                title: "確認",
//                style: .destructive,
//                handler: {_ in self.loadJSON(locationName: self.selectLocation, time: self.selectTime)}
//            )
//
//            alertView.view.addSubview(timePickerView)
//            alertView.addAction(cancelAction)
//            alertView.addAction(okAction)
//
//            present(alertView, animated: true, completion: nil)
//        }
//
//    }
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        tim ePickerView() // 點擊一下畫面可以選擇地點
//    }

}
// MARK: - 選擇器
//extension MainVC: UIPickerViewDataSource, UIPickerViewDelegate {
//
//    func numberOfComponents(in pickerView: UIPickerView) -> Int { return 1 }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        if pickerView == timePickerView {
//            // 三個時間區間
//            return timeData.count
//        }
//        return 0
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        if pickerView == timePickerView {
//            return timeData[row]
//        }
//        return nil
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        if pickerView == timePickerView {
//            selectTime = row // 改變時間
//        }
//    }
//
//}
// MARK: - protocol
extension MainVC: TableViewVCprotocol{
    func changeWeatherData(locationName:String){
        self.getWeatherData(locationName: grade)
    }
}
