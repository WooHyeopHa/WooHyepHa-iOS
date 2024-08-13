//
//  HomeCoordinator.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/13/24.
//

import UIKit

final class HomeCoordinator: Coordinator {
   weak  var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        goToHomeViewController()
    }
}

private extension HomeCoordinator {
    func goToHomeViewController() {
        let homeViewController = HomeViewController()
        navigationController.pushViewController(homeViewController, animated: true)
    }
}

