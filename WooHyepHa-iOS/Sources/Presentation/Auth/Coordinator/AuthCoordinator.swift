//
//  OnboardingCoordinator.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/14/24.
//

import UIKit

final class AuthCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    private let authRepository: AuthRepository
    private let signInUseCase: SignInUseCase
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
        navigationController.navigationBar.isHidden = true
        
        authRepository = AuthRepository()
        signInUseCase = SignInUseCase(authRepository: authRepository)
    }
    
    func start() {
        goToLoginViewController()
    }
}

extension AuthCoordinator {
    func goToLoginViewController() {
        let signViewModel = SignInViewModel(coordinator: self, signInUseCase: signInUseCase)
        let signViewController = SignInViewController(viewModel: signViewModel)
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = .fade
        transition.subtype = .fromRight
        navigationController.view.layer.add(transition, forKey: kCATransition)
        
        navigationController.pushViewController(signViewController, animated: false)
    }
    
    func goToRegisterViewController() {
        let registerViewController = SignUpViewController()
        registerViewController.coordinator = self
        navigationController.pushViewController(registerViewController, animated: true)
    }
    
    func goToRegisterNicknameViewController() {
        let registerNicknameViewModel = RegisterNicknameViewModel(coordinator: self)
        let registerNicknameViewController = RegisterNicknameViewController(viewModel: registerNicknameViewModel)
        navigationController.pushViewController(registerNicknameViewController, animated: true)
    }    
    
    func goToSignUpViewController() {
        let signUpViewController = SignUpViewController()
        signUpViewController.coordinator = self
        navigationController.pushViewController(signUpViewController, animated: true)
    }
    
    func goToRegisterLocationViewController() {
        let registerLocationViewController = RegisterLocationViewController()
        registerLocationViewController.coordinator = self
        navigationController.pushViewController(registerLocationViewController, animated: true)
    }    
    
    func goToRegisterPreferenceViewController() {
        let registerPreferenceViewController = RegisterPreferenceViewController()
        registerPreferenceViewController.coordinator = self
        navigationController.pushViewController(registerPreferenceViewController, animated: true)
    }
}
