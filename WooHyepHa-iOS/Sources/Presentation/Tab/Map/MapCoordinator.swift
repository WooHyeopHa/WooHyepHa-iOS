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
    
    private let tokenStorage = TokenStorage.shared
    private let mapRepository: MapRepository
    private let artRepository: ArtRepository
    
    private let mapUseCase: MapUseCase
    private let artUseCase: ArtUseCase
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        mapRepository = MapRepository()
        artRepository = ArtRepository()
        mapUseCase = MapUseCase(repository: mapRepository)
        artUseCase = ArtUseCase(repository: artRepository)
    }
    
    func start() {
        goToMapViewController()
    }
}

extension MapCoordinator {
    func goToDetailInfoViewController(artId: Int) {
        guard let uidString = try? tokenStorage.loadToken(type: .uid),
              let uid = Int(uidString) else {
            print("토큰 로드 실패")
            return
        }
        
        let detailInfoViewModel = DetailInfoViewModel(coordinator: self, artUseCase: artUseCase, artId: artId, uid: Int(uid))
        let detailInfoViewController = DetailInfoViewController(viewModel: detailInfoViewModel)
        navigationController.pushViewController(detailInfoViewController, animated: true)
    }
}

private extension MapCoordinator {
    func goToMapViewController() {
        let mapViewModel = MapViewModel(coordinator: self, mapUseCase: mapUseCase)
        let mapViewController = MapViewController(viewModel: mapViewModel)
        navigationController.pushViewController(mapViewController, animated: true)
    }
}
