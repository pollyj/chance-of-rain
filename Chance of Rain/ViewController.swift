//
//  ViewController.swift
//  Chance of Rain
//
//  Created by Polly Sutcliffe & Yuya Harada on 2020/05/03.
//  Copyright © 2020 Polly Sutcliffe & Yuya Harada. All rights reserved.
//

import UIKit
import CoreLocation


class ViewController: UIViewController {

    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    @IBOutlet weak var FutureWeatherIcon1: UIImageView!
    @IBOutlet weak var FutureWeatherIcon2: UIImageView!
    @IBOutlet weak var FutureWeatherIcon3: UIImageView!
    @IBOutlet weak var FutureWeatherIcon4: UIImageView!
    @IBOutlet weak var FutureWeatherMin1: UILabel!
    @IBOutlet weak var FutureWeatherMin2: UILabel!
    @IBOutlet weak var FutureWeatherMin3: UILabel!
    @IBOutlet weak var FutureWeatherMin4: UILabel!
    @IBOutlet weak var FutureWeatherMax1: UILabel!
    @IBOutlet weak var FutureWeatherMax2: UILabel!
    @IBOutlet weak var FutureWeatherMax3: UILabel!
    @IBOutlet weak var FutureWeatherMax4: UILabel!
    
    
    
    var weatherManager = WeatherManager()
    let locationManger = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManger.delegate = self
        locationManger.requestWhenInUseAuthorization()
        locationManger.requestLocation()
        
        weatherManager.delegate = self
        searchTextField.delegate = self
    }

}

extension ViewController: UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            weatherManager.fetchWeather(citysName: city)
        }
        searchTextField.text = ""
    }
}


extension ViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.weatherIcon.image = UIImage(systemName: weather.conditionName)
            
            self.cityLabel.text = weather.citysName
        }
        
        //didUpdateFutureWeather(<#T##weatherManager: WeatherManager##WeatherManager#>, weather: <#T##FutureWeatherModel#>)
    }
    
    func didUpdateFutureWeather(_ weatherManager: WeatherManager, weather: FutureWeatherModel) {
        DispatchQueue.main.async {

            self.FutureWeatherIcon1.image = UIImage(systemName: weather.conditionName1)
            self.FutureWeatherIcon2.image = UIImage(systemName: weather.conditionName2)
            self.FutureWeatherIcon3.image = UIImage(systemName: weather.conditionName3)
            self.FutureWeatherIcon4.image = UIImage(systemName: weather.conditionName4)

            self.FutureWeatherMin1.text = "\(weather.minString1)°C"
            self.FutureWeatherMin2.text = "\(weather.minString2)°C"
            self.FutureWeatherMin3.text = "\(weather.minString3)°C"
            self.FutureWeatherMin4.text = "\(weather.minString4)°C"

            self.FutureWeatherMax1.text = "\(weather.maxString1)°C"
            self.FutureWeatherMax2.text = "\(weather.maxString2)°C"
            self.FutureWeatherMax3.text = "\(weather.maxString3)°C"
            self.FutureWeatherMax4.text = "\(weather.maxString4)°C"
        }
    }
    
    
    func didFailWithError(error: Error) {
        print(error)
    }
}


extension ViewController: CLLocationManagerDelegate {
    
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManger.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManger.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
            weatherManager.fetchFutureWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
