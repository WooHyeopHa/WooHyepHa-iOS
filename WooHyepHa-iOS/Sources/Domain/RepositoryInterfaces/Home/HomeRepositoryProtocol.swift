//
//  HomeRepositoryProtocol.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/11/24.
//

import RxSwift

protocol HomeRepositoryProtocol {
    func fetchNowHome(userId: Int) -> Observable<NowHome>
    func fetchCultureCalendar(userId: Int, request: CultureCalendarRequestDTO) -> Observable<CultureCalendar>
    
    // Mock
    func fetchMockNowHome() -> Observable<NowHome>
    func fetchMockCultureCalendar() -> Observable<CultureCalendar>
}
