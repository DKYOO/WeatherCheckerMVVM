//
//  ViewController.swift
//  WeaterCheckerOnline
//
//  Created by Dmitry Kaveshnikov on 24.01.2022.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    // MARK: Hi there, here is the UI Elements
    
    let searchTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "City Name"
        textField.backgroundColor = .lightGray
        textField.alpha = 0.85
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.clearButtonMode = UITextField.ViewMode.whileEditing;
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.autocapitalizationType = .words
//        textField.isSecureTextEntry = true
        textField.returnKeyType = .go
        return textField
    }()
    
    #warning("You did a Great Job")
    
    // TODO: Add some beatifull things here like a VR AR: XR 😇
    
    let locationImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "location.circle.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    let searchImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "magnifyingglass.circle.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    let weatherTypeImage: UIImageView = {
        let imageView = UIImageView()
        let config = UIImage.SymbolConfiguration(pointSize: 50)
        imageView.image = UIImage(systemName: "cloud.sun.fill", withConfiguration: config)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let temratureCountLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 50, weight: .bold)
        label.textColor = .white
        label.textAlignment = .right
        label.text = "23"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let temratureTypeLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .white
        label.text = "ºC"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cityNameLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .right
        label.text = "London"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let backgroundView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "background")
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Add gesture Recognizer to the UIImage
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
        searchImage.addGestureRecognizer(tap)
        
        //Create Subviews
        self.view.addSubviews([backgroundView, searchTextField, locationImage, searchImage, weatherTypeImage, temratureCountLabel, temratureTypeLabel, cityNameLabel])
        
        //Ask permission to use User's Geoposition or Current location
        locationManager.requestWhenInUseAuthorization()
        
        //
        weatherManager.delegate = self
        searchTextField.delegate = self
        buildConstraints()
    }
    

    
    private func buildConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            searchTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            searchTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            searchTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            searchTextField.heightAnchor.constraint(equalToConstant: 30),
            
            locationImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            locationImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            locationImage.rightAnchor.constraint(equalTo: searchTextField.leftAnchor, constant: -10),
            locationImage.bottomAnchor.constraint(equalTo: searchTextField.bottomAnchor),
            
            searchImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            searchImage.leftAnchor.constraint(equalTo: searchTextField.rightAnchor, constant: 10),
            searchImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            searchImage.bottomAnchor.constraint(equalTo: searchTextField.bottomAnchor),
            
            weatherTypeImage.topAnchor.constraint(equalTo: searchImage.bottomAnchor, constant: 10),
            weatherTypeImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            weatherTypeImage.heightAnchor.constraint(equalToConstant: 80),
            weatherTypeImage.widthAnchor.constraint(equalToConstant: 80),
            
            temratureCountLabel.topAnchor.constraint(equalTo: weatherTypeImage.bottomAnchor, constant: 10),
            temratureCountLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            temratureCountLabel.heightAnchor.constraint(equalToConstant: 80),
            temratureCountLabel.widthAnchor.constraint(equalToConstant: 150),
            
            temratureTypeLabel.topAnchor.constraint(equalTo: weatherTypeImage.bottomAnchor, constant: 10),
            temratureTypeLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            temratureTypeLabel.heightAnchor.constraint(equalToConstant: 20),
            temratureTypeLabel.widthAnchor.constraint(equalToConstant: 20),
            
            
            cityNameLabel.topAnchor.constraint(equalTo: temratureCountLabel.bottomAnchor, constant: 10),
            cityNameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            cityNameLabel.heightAnchor.constraint(equalToConstant: 30),
            cityNameLabel.widthAnchor.constraint(equalToConstant: 150),

        ])
    }
 
}

//MARK: - Keyboard tricks

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        guard let text = searchTextField.text else {
            return false
        }
        print (text)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        //TODO: Use Guard 😎
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //TODO: Use searchTextField.text to get the weather from server
        
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }
    
    //MARK: Button functionality
    @objc func imageTapped(sender: UITapGestureRecognizer) {
        searchTextField.endEditing(true)
        guard let text = searchTextField.text else {
            return
        }
        print(text)
    }
}

extension ViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        
        DispatchQueue.main.async {
            self.temratureCountLabel.text = weather.tempratureString
            self.weatherTypeImage.image = UIImage(systemName: weather.conditionName)
            self.cityNameLabel.text = weather.cityName
        }
        
    }
    func didFailWithError(error: Error) {
        print (error)
    }
    
}


// TODO: Move to another File with extensions and call it Extensions 😂 with keyboard observer and other Usefull things
extension UIView {
    func addSubviews(_ views: [Any]) {
        views.forEach { if let view = $0 as? UIView {
            self.addSubview(view)
            }
        }
    }
}

