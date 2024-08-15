//
//  OnboardingCoordinator.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/14/24.
//

import UIKit

final class OnboardingCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
        navigationController.navigationBar.isHidden = true
    }
    
    func start() {
        goToLoginViewController()
    }
}

extension OnboardingCoordinator {
    func goToLoginViewController() {
        let loginViewController = LoginViewController()
        loginViewController.coordinator = self
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = .fade
        transition.subtype = .fromRight
        navigationController.view.layer.add(transition, forKey: kCATransition)
        
        navigationController.pushViewController(loginViewController, animated: false)
    }
}
