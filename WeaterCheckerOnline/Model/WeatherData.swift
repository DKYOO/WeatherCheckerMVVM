//
//  WeatherData.swift
//  WeaterCheckerOnline
//
//  Created by Dmitry Kaveshnikov on 18.02.2022.
//

import Foundation

// Codable this is Decodable with Encodable -> Typealias

struct WeatherData: Codable {
    
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    
    let temp: Double
    
}

struct Weather: Codable {
    let description: String
    let id: Int
}
