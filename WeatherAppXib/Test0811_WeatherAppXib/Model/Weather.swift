//
//  Weather.swift
//  Test0811_WeatherAppXib
//
//  Created by 侯懿玲 on 2021/8/11.
//

import UIKit
//依照JSON格式來寫結構
struct Weather: Codable {
    var records: records
}

struct records: Codable {
    var location: [location]
}

struct location: Codable {
    var locationName: String
    var weatherElement: [weatherElement]
}

struct weatherElement: Codable {
    var elementName: String
    var time: [time]
}

struct time: Codable {
    var startTime: String
    var endTime: String
    var parameter: parameter
}

struct parameter: Codable {
    var parameterName: String
    //parameterValue 和 parameterUnit 不一定存在
    var parameterValue: String?
    var parameterUnit: String?
}
