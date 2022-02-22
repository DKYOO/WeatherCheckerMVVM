//
//  WeatherModel.swift
//  WeaterCheckerOnline
//
//  Created by Dmitry Kaveshnikov on 21.02.2022.
//

import Foundation

struct WeatherModel {
    
    let conditionID: Int
    let cityName: String
    let temprature: Double
    
    //format to one decimal string from Double temrature
    var tempratureString: String {
        return String(format: "%.1f", temprature)
    }
    
    var conditionName: String {
        switch conditionID {
        case 200...232: return "cloud.bolt"
        case 300...321: return "cloud.dizzle"
        case 500...531: return "cloud.rain"
        case 600...622: return "cloud.snow"
        case 700...781: return "cloud.fog"
        case 801...804: return "cloud.bolt"
        case 800: return "sun.max"
        default: return ("cloud")
        }
    }

}
