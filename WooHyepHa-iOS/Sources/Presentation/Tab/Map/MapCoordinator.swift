//
//  MapCoordinator.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/13/24.
//

import UIKit

final class MapCoordinator: Coordinator {
   weak  var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        goToMapViewController()
    }
}

private extension MapCoordinator {
    func goToMapViewController() {
        let MapViewController = MapViewController()
        navigationController.pushViewController(MapViewController, animated: true)
    }
}
