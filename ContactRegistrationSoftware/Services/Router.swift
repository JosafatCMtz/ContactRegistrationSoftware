//
//  Router.swift
//  ContactRegistrationSoftware
//
//  Created by Josafat Martínez  on 09/07/22.
//

import UIKit

class Router {
    var viewController: UIViewController {
        return createViewController()
    }
    
    private var sourceView: UIViewController?
    
    func createViewController() -> UIViewController {
        let nibName: String = String(describing: MenuViewController.self)
        let view = MenuViewController(nibName: nibName, bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView: UIViewController?) {
        guard let view = sourceView else { fatalError("Unknow Error") }
        self.sourceView = view
    }
}
