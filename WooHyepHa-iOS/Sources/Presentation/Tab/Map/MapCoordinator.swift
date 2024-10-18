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
    
    private let mapRepository: MapRepository
    private let mapUseCase: MapUseCase
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        mapRepository = MapRepository()
        mapUseCase = MapUseCase(repository: mapRepository)
    }
    
    func start() {
        goToMapViewController()
    }
}

private extension MapCoordinator {
    func goToMapViewController() {
        let mapViewModel = MapViewModel(mapUseCase: mapUseCase)
        let mapViewController = MapViewController(viewModel: mapViewModel)
        navigationController.pushViewController(mapViewController, animated: true)
    }
}
