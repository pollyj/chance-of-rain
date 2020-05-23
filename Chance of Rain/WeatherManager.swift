//
//  Weather.swift
//  Chance of Rain
//
//  Created by Polly Sutcliffe on 2020/05/04.
//  Copyright © 2020 Yuya Harada. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didUpdateFutureWeather(_ weatherManager: WeatherManager, weather: FutureWeatherModel)
    func didFailWithError(error: Error)
    
}

struct WeatherManager {
    let weatherURL =
    "https://api.openweathermap.org/data/2.5/weather?appid=bf34339e60550c61392c04f598f14058&units=metric"
    
    let futureWeatherURL = "https://api.openweathermap.org/data/2.5/onecall?exclude=currently,minutely,hourly&appid=bf34339e60550c61392c04f598f14058&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(citysName: String) {
        let urlString = "\(weatherURL)&q=\(citysName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func fetchFutureWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let futureUrlString = "\(futureWeatherURL)&lat=\(latitude)&lon=\(longitude)"
        performFutureWeatherRequest(with: futureUrlString)
    }
    
    func performRequest(with urlString: String){
        //1. Create a URL
        if let url = URL(string: urlString) {
            
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            
            //3. Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            
            //4. Start the task
            task.resume()
        }
    }
    
    func performFutureWeatherRequest(with urlString: String){
        //1. Create a URL
        if let url = URL(string: urlString) {

            //2. Create a URLSession
            let session = URLSession(configuration: .default)

            //3. Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSONForFutureWeather(safeData) {
                        self.delegate?.didUpdateFutureWeather(self, weather: weather)
                    }
                }
            }

            //4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()

        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let lat = decodedData.coord.lat
            let lon = decodedData.coord.lon
            
            let weather = WeatherModel(conditionId: id, citysName: name, temperature: temp, lat: lat, lon: lon)
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    func parseJSONForFutureWeather(_ weatherData: Data) -> FutureWeatherModel? {
        let decoder = JSONDecoder()

        do {
            let decodedData = try decoder.decode(FutureWeatherData.self, from: weatherData)
            print(decodedData)
            let id1 = decodedData.current.weather[0].id
            let minTemp1 = decodedData.daily[1].temp.min
            let maxTemp1 = decodedData.daily[1].temp.max

            let id2 = decodedData.daily[2].weather[0].id
            let minTemp2 = decodedData.daily[2].temp.min
            let maxTemp2 = decodedData.daily[2].temp.max

            let id3 = decodedData.daily[3].weather[0].id
            let minTemp3 = decodedData.daily[3].temp.min
            let maxTemp3 = decodedData.daily[3].temp.max

            let id4 = decodedData.daily[4].weather[0].id
            let minTemp4 = decodedData.daily[4].temp.min
            let maxTemp4 = decodedData.daily[4].temp.max

            let weather = FutureWeatherModel(conditionId1: id1, min1: minTemp1, max1: maxTemp1, conditionId2: id2, min2: minTemp2, max2: maxTemp2, conditionId3: id3, min3: minTemp3, max3: maxTemp3, conditionId4: id4, min4: minTemp4, max4: maxTemp4)
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
