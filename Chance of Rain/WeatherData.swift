//
//  WeatherData.swift
//  Chance of Rain
//
//  Created by Polly Sutcliffe on 2020/05/17.
//  Copyright © 2020 Yuya Harada. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
}
