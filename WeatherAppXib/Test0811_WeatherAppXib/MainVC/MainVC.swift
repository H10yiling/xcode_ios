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
    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var pop: UILabel!
    @IBOutlet weak var maxT: UILabel!
    @IBOutlet weak var minT: UILabel!
    @IBOutlet weak var wx: UILabel!
    @IBOutlet weak var otherCitys: UIButton!

// MARK: - var
    
    var authorization = "CWB-947F44DD-8419-4325-B916-47FCB530D292" // 會員碼
    override func viewDidLoad() {
        super.viewDidLoad()
        getWeatherData(locationName:grade) // 進入畫面前先讀一次 JSON
        self.navigationController?.hidesBarsOnTap = true // 按一下收起navigationBar
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
                }
            }
            else {print("error")}
        }
        task.resume()
    }
    
// MARK: - 依據舒適度（ wx ）搭配適合的 weather Icon
    
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
}

// MARK: - protocol

extension MainVC: TableViewVCprotocol{
    func changeWeatherData(locationName:String){
        self.getWeatherData(locationName: grade)
    }
}
