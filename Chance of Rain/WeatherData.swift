//
//  WeatherData.swift
//  Chance of Rain
//
//  Created by Polly Sutcliffe on 2020/05/17.
//  Copyright © 2020 Yuya Harada. All rights reserved.
//

import Foundation
import CoreLocation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let coord: Coord
}

struct Coord: Codable {
    let lat: CLLocationDegrees
    let lon: CLLocationDegrees
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
}

struct Days: Codable {
    let weather: [Weather]
    let temp: Temp
}

struct Temp: Codable {
    let min: Double
    let max: Double
}

struct FutureWeatherData: Codable {
    let current: Current
    let daily: [Days]
}

struct Current: Codable {
    let weather: [Weather]
}
