//
//  TabBarCoordinator.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/13/24.
//

import UIKit

final class TabBarCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        self.tabBarController = UITabBarController()
    }
    
    func start() {
        let items = TabBarItemType.allCases
        let viewControllers = items.map { createTabNavigationController(of: $0) }
        configureTabBarController(with: viewControllers)
    }
}

private extension TabBarCoordinator {
    func configureTabBarController(with viewControllers: [UIViewController]) {
        tabBarController.tabBar.backgroundColor = .white
        
        let topBorder = CALayer()
        topBorder.frame = CGRect(x:0, y:0, width: tabBarController.tabBar.frame.width, height: 1)
        topBorder.backgroundColor = UIColor.gray.cgColor
        tabBarController.tabBar.layer.addSublayer(topBorder)
        
        tabBarController.viewControllers = viewControllers
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(tabBarController, animated: false)
    }
    
    func createTabNavigationController(of item: TabBarItemType) -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = item.tabBarItem
        navigationController.navigationBar.isHidden = true
        connectTabCoordinator(of: item, to: navigationController)
        return navigationController
    }
    
    func connectTabCoordinator(of item: TabBarItemType, to tabNavigationController: UINavigationController) {
        switch item {
        case .home:
            goToHomeTab(to: tabNavigationController)
            
        case .mating:
            goToMatingTab(to: tabNavigationController)
            
        case .map:
            goToMapTab(to: tabNavigationController)
            
        case .chat:
            goToChatTab(to: tabNavigationController)
            
        case .mypage:
            goToMyPageTab(to: tabNavigationController)
        }
    }
    
    func goToHomeTab(to tabNavigationController: UINavigationController) {
        let homeCoordinator = HomeCoordinator(navigationController: tabNavigationController)
        homeCoordinator.start()
        homeCoordinator.parentCoordinator = self
        children.append(homeCoordinator)
    }
    
    func goToMatingTab(to tabNavigationController: UINavigationController) {
        let matingCoordinator = MatingCoordinator(navigationController: tabNavigationController)
        matingCoordinator.start()
        matingCoordinator.parentCoordinator = self
        children.append(matingCoordinator)
    }
    
    func goToMapTab(to tabNavigationController: UINavigationController) {
        let mapCoordinator = MapCoordinator(navigationController: tabNavigationController)
        mapCoordinator.start()
        mapCoordinator.parentCoordinator = self
        children.append(mapCoordinator)
    }
    
    func goToChatTab(to tabNavigationController: UINavigationController) {
        let chatCoordinator = ChatCoordinator(navigationController: tabNavigationController)
        
        chatCoordinator.start()
        chatCoordinator.parentCoordinator = self
        children.append(chatCoordinator)
    }
    
    func goToMyPageTab(to tabNavigationController: UINavigationController) {
        let mypageCoordinator = MyPageCoordinator(navigationController: tabNavigationController)
        mypageCoordinator.start()
        mypageCoordinator.parentCoordinator = self
        children.append(mypageCoordinator)
    }
}
