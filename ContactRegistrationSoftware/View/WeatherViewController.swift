//
//  WeatherViewController.swift
//  ContactRegistrationSoftware
//
//  Created by Josafat Martínez  on 09/07/22.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var weatherInfoLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    
    private var viewModel: WeatherViewModel = WeatherViewModel()
    private var router: Router = Router()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(to: self, withRouter: router)
        getCurrentWeather()
    }
    private func emptyAlert() {
        let dialogMessage = UIAlertController(title: "Clima Incorrecto", message: "Lo sentimos, hubo un erro al obtener el clima actual", preferredStyle: .alert)
        let bactToMenu = UIAlertAction(title: "Cancelar", style: .destructive, handler: { _ in
            self.navigationController?.pushViewController(MenuViewController(), animated: true)
        })
        
        dialogMessage.addAction(bactToMenu)
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    private func setImageWeatherAndInfo(weaterData: String, in imageView: UIImageView, info label: UILabel) {
        switch weaterData {
        case "clearday", "clearnight":
            imageView.image = UIImage(systemName: "sun.max.fill")?.withRenderingMode(.alwaysOriginal)
            label.text = "Soleado"
        case "pcloudyday", "pcloudynight", "mcloudyday", "mcloudynight", "cloudyday", "cloudynight", "humidday", "humidnight":
            imageView.image = UIImage(systemName: "cloud.sun.fill")?.withRenderingMode(.alwaysOriginal)
            label.text = "Soleado Con nubes"
        case "lightrainday", "lightrainnight", "oshowerday", "oshowernight", "ishowerday", "ishowernight":
            imageView.image = UIImage(systemName: "cloud.rain.fill")?.withRenderingMode(.alwaysOriginal)
            label.text = "Lloviendo"
        default:
            imageView.image = UIImage(systemName: "cloud.snow.fill")?.withRenderingMode(.alwaysOriginal)
            label.text = "Esta Nevando"
        }
    }
    
    private func getCurrentWeather() {
        DispatchQueue.main.async {
            self.viewModel.getCurrentWeatherFrom(lon: "-100.89860448308039", lat: "25.424598522035772") { result in
                switch result {
                case .success(let weaterData):
                    self.weatherInfoLabel.text = "\(weaterData.temp)°"
                    self.setImageWeatherAndInfo(weaterData: weaterData.weather, in: self.weatherImageView, info: self.weatherDescriptionLabel)
                case .failure(_):
                    self.emptyAlert()
                }
            }
        }
    }
}

