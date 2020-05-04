//
//  Weather.swift
//  Chance of Rain
//
//  Created by Polly Sutcliffe on 2020/05/04.
//  Copyright © 2020 Yuya Harada. All rights reserved.
//

import Foundation

struct weather {
    let weatherURL =
    "https://api.openweathermap.org/data/2.5/weather?q=tokyo,jp&appid=bf34339e60550c61392c04f598f14058&units=metric"
    
    func fetchWeather() {
        performRequest(weatherURL: weatherURL)
    }
    
    func performRequest(weatherURL: String){
        //1. Create a URL
        let url = URL(string: weatherURL)
        
        //2. Create a URLSession
        
        let session = URLSession(configuration: .default)
        
        //3. Give the session a task
        
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            if let safeData = data {
                //calling struct method within a closure requires "self."
                self.parseJSON(weatherData: safeData)
            }
        }
        
        //4. Start the task
        task.resume()
    }
    
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            getConditionName(weatherId: id)
        } catch {
            print(error)
        }
    }
    
    func getConditionName(weatherId: Int) -> String {
        switch weatherId {
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








