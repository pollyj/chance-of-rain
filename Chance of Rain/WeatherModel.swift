//
//  WeatherModel.swift
//  Chance of Rain
//
//  Created by Polly Sutcliffe on 2020/05/17.
//  Copyright © 2020 Yuya Harada. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let citysName: String
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionId {
            case 200...232:
                return "cloud.bolt"
            case 300...321:
                return "cloud.drizzle"
            case 500...531:
                return "cloud.rain"
            case 600...622:
                return "cloud.snow"
            case 701...781:
                return "cloud.fog"
            case 800:
                return "sun.max"
            case 801...804:
                return "cloud.bolt"
            default:
                return "cloud"
        }
    }
}

struct FutureWeatherModel {
    let conditionId1: Int
    let min1: Double
    let max1: Double

    let conditionId2: Int
    let min2: Double
    let max2: Double

    let conditionId3: Int
    let min3: Double
    let max3: Double

    let conditionId4: Int
    let min4: Double
    let max4: Double

    var minString1: Int {
        return Int(min1)
    }
    var maxString1: Int {
        return Int(max1)
    }

    var minString2: Int {
        return Int(min2)
    }
    var maxString2: Int {
        return Int(max2)
    }

    var minString3: Int {
        return Int(min3)
    }
    var maxString3: Int {
        return Int(max3)
    }

    var minString4: Int {
        return Int(min4)
    }
    var maxString4: Int {
        return Int(max4)
    }

    var conditionName1: String {
        switch conditionId1 {
            case 200...232:
                return "cloud.bolt"
            case 300...321:
                return "cloud.drizzle"
            case 500...531:
                return "cloud.rain"
            case 600...622:
                return "cloud.snow"
            case 701...781:
                return "cloud.fog"
            case 800:
                return "sun.max"
            case 801...804:
                return "cloud.bolt"
            default:
                return "cloud"
        }
    }

    var conditionName2: String {
        switch conditionId2 {
            case 200...232:
                return "cloud.bolt"
            case 300...321:
                return "cloud.drizzle"
            case 500...531:
                return "cloud.rain"
            case 600...622:
                return "cloud.snow"
            case 701...781:
                return "cloud.fog"
            case 800:
                return "sun.max"
            case 801...804:
                return "cloud.bolt"
            default:
                return "cloud"
        }
    }


    var conditionName3: String {
        switch conditionId3 {
            case 200...232:
                return "cloud.bolt"
            case 300...321:
                return "cloud.drizzle"
            case 500...531:
                return "cloud.rain"
            case 600...622:
                return "cloud.snow"
            case 701...781:
                return "cloud.fog"
            case 800:
                return "sun.max"
            case 801...804:
                return "cloud.bolt"
            default:
                return "cloud"
        }
    }


    var conditionName4: String {
        switch conditionId4 {
            case 200...232:
                return "cloud.bolt"
            case 300...321:
                return "cloud.drizzle"
            case 500...531:
                return "cloud.rain"
            case 600...622:
                return "cloud.snow"
            case 701...781:
                return "cloud.fog"
            case 800:
                return "sun.max"
            case 801...804:
                return "cloud.bolt"
            default:
                return "cloud"
        }
    }
}
