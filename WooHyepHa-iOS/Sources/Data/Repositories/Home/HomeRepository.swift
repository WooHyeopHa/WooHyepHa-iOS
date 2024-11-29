//
//  HomeRepository.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/11/24.
//

import RxSwift
import Moya

final class HomeRepository: NSObject, HomeRepositoryProtocol {
    
    private let service = MoyaProvider<HomeService>(plugins: [TokenPlugin()])
    
    func fetchNowHome(userId: Int) -> Observable<NowHome> {
        return service.rx.request(.fetchNowHome(userId: userId))
            .filterSuccessfulStatusCodes()
            .map { response -> NowHome in
                print("상태 코드 : \(response.statusCode)")
                let res = try JSONDecoder().decode(NowHomeResponsesDTO.self, from: response.data)
                return res.toEntity()
            }.asObservable()
            .catch { error in
                print("fetchError")
                return Observable.error(error)
            }.asObservable()
    }
    
    func fetchCultureCalendar(userId: Int, request: CultureCalendarRequestDTO) -> Observable<CultureCalendar> {
        return service.rx.request(.fetchCultureCalendar(userId: userId, request: request))
            .filterSuccessfulStatusCodes()
            .map { response -> CultureCalendar in
                print("상태 코드 : \(response.statusCode)")
                let res = try JSONDecoder().decode(CultureCalendarResponsesDTO.self, from: response.data)
                return res.toEntity()
            }.asObservable()
            .catch { error in
                print("fetchError")
                return Observable.error(error)
            }.asObservable()
    }
}

// Mock
extension HomeRepository {
    func fetchMockNowHome() -> Observable<NowHome> {
        .just(NowHomeResponsesDTO.testData.toEntity())
    }
    
    func fetchMockCultureCalendar() -> Observable<CultureCalendar> {
        .just(CultureCalendarResponsesDTO.testData.toEntity())
    }
}
