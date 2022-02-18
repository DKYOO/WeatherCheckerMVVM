//
//  WeatherData.swift
//  WeaterCheckerOnline
//
//  Created by Dmitry Kaveshnikov on 18.02.2022.
//

import Foundation

struct WeatherData: Decodable {
    
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    
    let temp: Double
    
}

struct Weather: Decodable {
    
    let description: String
}
