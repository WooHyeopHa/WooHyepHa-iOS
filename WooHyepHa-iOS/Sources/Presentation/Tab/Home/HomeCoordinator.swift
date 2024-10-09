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

extension HomeCoordinator {
    func goToHomeViewController() {
        let homeViewController = HomeViewController()
        homeViewController.coordinator = self
        navigationController.pushViewController(homeViewController, animated: true)
    }
    
    func goToCultureCalendarViewController() {
        let cultureCalendarViewController = CultureCalendarViewController()
        cultureCalendarViewController.coordinator = self
        
        cultureCalendarViewController.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(cultureCalendarViewController, animated: false)
    }
}

