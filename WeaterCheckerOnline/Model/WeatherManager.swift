//
//  WeatherManager.swift
//  WeaterCheckerOnline
//
//  Created by Dmitry Kaveshnikov on 12.02.2022.
//

import Foundation

protocol WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=7f90ef7915f3ff0c8320d7417e950a2b&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        //create URL:
        
        if let url = URL(string: urlString) {
            //create URLSession
            
            let session = URLSession(configuration: .default)
            
            // Give the session a task
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            //Start the task
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
            
            let weather = WeatherModel(conditionID: id, cityName: name, temprature: temp)
            
            print (weather.conditionName)
            print (weather.tempratureString)
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }

    
}
