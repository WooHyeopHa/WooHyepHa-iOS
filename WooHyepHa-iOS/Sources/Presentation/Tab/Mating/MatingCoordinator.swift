//
//  MatingCoordinator.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/13/24.
//

import UIKit

final class MatingCoordinator: Coordinator {
   weak  var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        goToMatingViewController()
    }
}

private extension MatingCoordinator {
    func goToMatingViewController() {
        let matingViewController = MatingViewController()
        navigationController.pushViewController(matingViewController, animated: true)
    }
}
