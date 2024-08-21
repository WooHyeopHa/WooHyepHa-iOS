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
        transition.duration = 0.3
        transition.type = .fade
        transition.subtype = .fromRight
        navigationController.view.layer.add(transition, forKey: kCATransition)
        
        navigationController.pushViewController(loginViewController, animated: false)
    }
    
    func goToRegisterViewController() {
        let registerViewController = RegisterViewController()
        registerViewController.coordinator = self
        navigationController.pushViewController(registerViewController, animated: true)
    }
    
    func goToRegisterProfileViewController() {
        let registerProfileViewController = RegisterProfileViewController()
        registerProfileViewController.coordinator = self
        navigationController.pushViewController(registerProfileViewController, animated: true)
    }
    
    func goToRegisterLocationViewController() {
        let registerLocationViewController = RegisterLocationViewController()
        registerLocationViewController.coordinator = self
        navigationController.pushViewController(registerLocationViewController, animated: true)
    }    
    
    func goToRegisterPreferenceCultureViewController() {
        let registerPreferenceCultureViewController = RegisterPreferenceCultrueViewController()
        registerPreferenceCultureViewController.coordinator = self
        navigationController.pushViewController(registerPreferenceCultureViewController, animated: true)
    }
    
    func goToRegisterPreferenceExhibitionViewController() {
        let registerPreferenceExhibitionViewController = RegisterPreferenceExhibitionViewController()
        registerPreferenceExhibitionViewController.coordinator = self
        navigationController.pushViewController(registerPreferenceExhibitionViewController, animated: true)
    }
    
    func goToRegisterPreferenceConcertViewController() {
        let registerPreferenceConcertViewController = RegisterPreferenceConcertViewController()
        registerPreferenceConcertViewController.coordinator = self
        navigationController.pushViewController(registerPreferenceConcertViewController, animated: true)
    }    
    
    func goToRegisterPreferenceMusicalViewController() {
        let registerPreferenceMusicalViewController = RegisterPreferenceMusicalViewController()
        registerPreferenceMusicalViewController.coordinator = self
        navigationController.pushViewController(registerPreferenceMusicalViewController, animated: true)
    }    
    
    func goToRegisterPreferenceClassicViewController() {
        let registerPreferenceClassicViewController = RegisterPreferenceClassicViewController()
        registerPreferenceClassicViewController.coordinator = self
        navigationController.pushViewController(registerPreferenceClassicViewController, animated: true)
    }
}
