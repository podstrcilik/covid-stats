//
//  MainTabBarController.swift
//  covid
//
//  Created by Pavel Odstrčilík on 30.12.2020.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareControllers()
    }

    open func prepareControllers() {
        self.viewControllers = [
            prepareViewController(viewController: MainViewController(), title: "Statistiky", iconName: "list.dash"),
            prepareViewController(viewController: AboutViewController(), title: "O aplikaci", iconName: "info.circle")
        ]
    }

    open func prepareViewController(viewController: UIViewController, title: String, iconName: String?) -> UINavigationController {
        let viewController = viewController
        viewController.title = title
        let imageFromSymbols = UIImage.init(systemName: iconName ?? "")
        let tabBarItem = UITabBarItem(title: title, image: imageFromSymbols, selectedImage: nil)
        viewController.tabBarItem = tabBarItem
        let navigationViewController = UINavigationController(rootViewController: viewController)
        navigationViewController.isNavigationBarHidden = true
        return navigationViewController
    }
}
