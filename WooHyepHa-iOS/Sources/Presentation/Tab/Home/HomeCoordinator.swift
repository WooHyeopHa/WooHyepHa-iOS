//
//  HomeCoordinator.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/13/24.
//

import UIKit

final class HomeCoordinator: Coordinator {
   weak  var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    private let homeRepository: HomeRepository
    private let nowHomeUseCase: NowHomeUseCase
    private let cultureCalendarUseCase: CultureCalendarUseCase
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        homeRepository = HomeRepository()
        nowHomeUseCase = NowHomeUseCase(homeRepository: homeRepository)
        cultureCalendarUseCase = CultureCalendarUseCase(homeRepository: homeRepository)
    }
    
    func start() {
        goToHomeViewController()
    }
}

extension HomeCoordinator {
    func goToHomeViewController() {
        let homeViewModel = HomeViewModel(coordinator: self, homeUseCase: nowHomeUseCase)
        let homeViewController = HomeViewController(viewModel: homeViewModel)
        navigationController.pushViewController(homeViewController, animated: true)
    }
    
    func goToCultureCalendarViewController() {
        let cultureCalendarViewModel = CultureCalendarViewModel(coordinator: self, cultureCalendarUseCase: cultureCalendarUseCase)
        let cultureCalendarViewController = CultureCalendarViewController(viewModel: cultureCalendarViewModel)
        navigationController.pushViewController(cultureCalendarViewController, animated: false)
    }
    
    func goToAlarmViewController() {
        let alarmViewModel = AlarmViewModel(coordinator: self, homeUseCase: nowHomeUseCase)
        let alarmViewController = AlarmViewController(viewModel: alarmViewModel)
        navigationController.pushViewController(alarmViewController, animated: false)
    }
}

