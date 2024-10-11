//
//  HomeUseCase.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/11/24.
//

import RxSwift

protocol NowHomeUseCaseProtocol {
    func fetchNowHome(userId: Int) -> Observable<NowHome>
    
    // Mock
    func fetchMockNowHome() -> Observable<NowHome>
}

final class NowHomeUseCase: NowHomeUseCaseProtocol {

    private let homeRepository: HomeRepositoryProtocol
    
    init(homeRepository: HomeRepositoryProtocol) {
        self.homeRepository = homeRepository
    }
    
    func fetchNowHome(userId: Int) -> Observable<NowHome> {
        homeRepository.fetchNowHome(userId: userId)
    }
    
    func fetchMockNowHome() -> Observable<NowHome> {
        homeRepository.fetchMockNowHome()
    }
}
