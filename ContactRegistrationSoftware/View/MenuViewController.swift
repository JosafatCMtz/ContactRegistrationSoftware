//
//  MenuViewController.swift
//  ContactRegistrationSoftware
//
//  Created by Josafat Martínez  on 09/07/22.
//

import UIKit

class MenuViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func goToAddContact() {
        let viewController: UIViewController = ContactFormViewController()
        let animated: Bool = true
        self.navigationController?.pushViewController(viewController, animated: animated)
    }
    @IBAction func goToViewContacts() {
        let viewController: UIViewController = ContactsViewController()
        let animated: Bool = true
        self.navigationController?.pushViewController(viewController, animated: animated)
    }
    @IBAction func goToWeather() {
        let viewController: UIViewController = WeatherViewController()
        let animated: Bool = true
        self.navigationController?.pushViewController(viewController, animated: animated)
    }
}
