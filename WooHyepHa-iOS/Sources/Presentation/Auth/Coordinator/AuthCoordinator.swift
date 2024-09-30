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
    
    func goToRegisterNicknameViewController() {
        let registerNicknameViewModel = RegisterNicknameViewModel(coordinator: self)
        let registerNicknameViewController = RegisterNicknameViewController(viewModel: registerNicknameViewModel)
        navigationController.pushViewController(registerNicknameViewController, animated: true)
    }    
    
    func goToSignUpViewController() {
        let signUpViewModel = SignUpViewModel(coordinator: self)
        let signUpViewController = SignUpViewController(viewModel: signUpViewModel)
        navigationController.pushViewController(signUpViewController, animated: true)
    }
    
    func goToRegisterProfileViewController() {
        let registerProfileViewModel = RegisterProfileViewModel(coordinator: self)
        let registerProfileViewController = RegisterProfileViewController(viewModel: registerProfileViewModel)
        navigationController.pushViewController(registerProfileViewController, animated: true)
    }
    
    func goToRegisterLocationViewController() {
        let registerLocationViewModel = RegisterLocationViewModel(coordinator: self)
        let registerLocationViewController = RegisterLocationViewController(viewModel: registerLocationViewModel)
        navigationController.pushViewController(registerLocationViewController, animated: true)
    }    
    
    func goToRegisterPreferenceViewController() {
        let registerPreferenceViewModel = RegisterPreferenceViewModel(coordinator: self)
        let registerPreferenceViewController = RegisterPreferenceViewController(viewModel: registerPreferenceViewModel)
        navigationController.pushViewController(registerPreferenceViewController, animated: true)
    }
}
