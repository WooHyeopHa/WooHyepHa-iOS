//
//  HomeRepositoryProtocol.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/11/24.
//

import RxSwift

protocol HomeRepositoryProtocol {
    func fetchNowHome(userId: Int) -> Observable<NowHome>
    
    // Mock
    func fetchMockNowHome() -> Observable<NowHome>
}
