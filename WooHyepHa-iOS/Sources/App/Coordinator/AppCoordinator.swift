//
//  AppCoordinator.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/13/24.
//

import UIKit

final class AppCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    func start() {
        print("앱 코디네이터 스타트")
        showSplashScreen()
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("앱 코디네이터 해제")
    }
    
    private func showSplashScreen() {
        let splashViewController = SplashViewController()
        navigationController.setViewControllers([splashViewController], animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            // Auth 상태에 따른 분기처리 구현해야함.
            self?.connectTabBarFlow()
        }
    }
}

extension AppCoordinator {
    func connectOnboardingFlow() {
        
    }
    
    func connectTabBarFlow() {
        //navigationController.popToRootViewController(animated: true)
        let tabBarCoordinator = TabBarCoordinator(navigationController: navigationController)
        tabBarCoordinator.parentCoordinator = self
        children.append(tabBarCoordinator)
        tabBarCoordinator.start()
    }
}
