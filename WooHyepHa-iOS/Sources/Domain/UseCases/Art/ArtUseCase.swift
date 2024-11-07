//
//  ArtUseCase.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 11/7/24.
//

import RxSwift
import CoreLocation

protocol ArtUseCaseProtocol {
    func fetchDetailArtInfo(artId: Int) -> Observable<DetailArt>
}

final class ArtUseCase: ArtUseCaseProtocol {
    private let repository: ArtRepositoryProtocol
    
    init(repository: ArtRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchDetailArtInfo(artId: Int) -> Observable<DetailArt> {
        return repository.fetchDetailArtInfo(artId: artId).asObservable()
    }
}
