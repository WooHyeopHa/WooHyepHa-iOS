//
//  CultureCalendarUseCase.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/15/24.
//

import RxSwift

protocol CultureCalendarUseCaseProtocol {
    func fetchCultureCalendar(userId: Int, request: CultureCalendarRequestDTO) -> Observable<CultureCalendar>
    
    // Mock
    func fetchMockCultureCalendar() -> Observable<CultureCalendar>
}

final class CultureCalendarUseCase: CultureCalendarUseCaseProtocol {

    private let homeRepository: HomeRepositoryProtocol
    
    init(homeRepository: HomeRepositoryProtocol) {
        self.homeRepository = homeRepository
    }
    
    func fetchCultureCalendar(userId: Int, request: CultureCalendarRequestDTO) -> Observable<CultureCalendar> {
        homeRepository.fetchCultureCalendar(userId: userId, request: request)
    }
    
    func fetchMockCultureCalendar() -> Observable<CultureCalendar> {
        homeRepository.fetchMockCultureCalendar()
    }

}
