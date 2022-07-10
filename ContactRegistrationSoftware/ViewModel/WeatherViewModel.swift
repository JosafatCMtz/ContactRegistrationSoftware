//
//  WeatherViewModel.swift
//  ContactRegistrationSoftware
//
//  Created by Josafat Martínez  on 09/07/22.
//

import UIKit

class WeatherViewModel{
    
    private(set) weak var view: WeatherViewController?
    private var router: Router?
    
    struct WeatherUI {
        let temp: Int
        let weather: String
    }
    enum WeatherError: Error {
        case noWeatherExtract
    }
    
    func bind(to view: WeatherViewController, withRouter router: Router) {
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func getCurrentWeatherFrom(lon: String, lat: String, completion: @escaping (Result<WeatherUI, WeatherError>)->()) {
        Services.shared.getWeatherFrom(lon: lon, lat: lat) { result in
            switch result {
            case .success(let weather):
                guard let currentWeatherInfo = weather.dataseries?[0] else { return }
                let weatherUI: WeatherUI = .init(temp: currentWeatherInfo.temp2M!, weather: currentWeatherInfo.weather!)
                completion(.success(weatherUI))
            default:
                completion(.failure(.noWeatherExtract))
            }
        }
    }
}
