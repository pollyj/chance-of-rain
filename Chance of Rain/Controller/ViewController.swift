//
//  ViewController.swift
//  Chance of Rain
//
//  Created by Polly Sutcliffe & Yuya Harada on 2020/05/03.
//  Copyright © 2020 Polly Sutcliffe & Yuya Harada. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    var weatherManager = weatherManager(){
        
    }

    @IBOutlet weak var cityName: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }


}

