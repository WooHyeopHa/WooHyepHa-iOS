//
//  MyPageCoordinator.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/13/24.
//

import UIKit

final class MyPageCoordinator: Coordinator {
   weak  var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        goToMyPageViewController()
    }
}

private extension MyPageCoordinator {
    func goToMyPageViewController() {
        let mypageViewController = MyPageViewController()
        navigationController.pushViewController(mypageViewController, animated: true)
    }
}
