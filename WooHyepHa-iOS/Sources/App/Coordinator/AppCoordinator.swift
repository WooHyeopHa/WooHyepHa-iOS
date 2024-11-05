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
            //self?.connectAuthFlow()
            //self?.connectTabBarFlow()
            self?.checkAuthenticationAndStart()
        }
    }
    
    private func checkAuthenticationAndStart() {
        if TokenStorage.shared.validateAuthentication() {
            print("✅ 저장된 토큰 있음 - 메인 화면으로 이동")
            connectTabBarFlow()
        } else {
            print("⚠️ 인증 필요 - 로그인 화면으로 이동")
            connectAuthFlow()
        }
    }
}

extension AppCoordinator {
    func connectAuthFlow() {
        let authCoordinator = AuthCoordinator(navigationController: navigationController)
        authCoordinator.parentCoordinator = self
        children.append(authCoordinator)
        authCoordinator.start()
    }
    
    func connectTabBarFlow() {
        //navigationController.popToRootViewController(animated: true)
        let tabBarCoordinator = TabBarCoordinator(navigationController: navigationController)
        tabBarCoordinator.parentCoordinator = self
        children.append(tabBarCoordinator)
        tabBarCoordinator.start()
    }
}
