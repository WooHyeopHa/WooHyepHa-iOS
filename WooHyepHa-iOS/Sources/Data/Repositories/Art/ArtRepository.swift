//
//  ArtRepository.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 11/7/24.
//

import RxSwift
import Moya

final class ArtRepository: ArtRepositoryProtocol {
    
    private let disposeBag = DisposeBag()

    private let service = MoyaProvider<MapService>()
    
    init() { }

    func fetchDetailArtInfo(artId: Int) -> Observable<DetailArt> {
        return service.rx.request(.fetchDetailArtInfo(artId: artId))
            .filterSuccessfulStatusCodes()
            .map { response -> DetailArt in
                print("상태 코드 : \(response.statusCode)")
                let res = try JSONDecoder().decode(DetailArtResponsesDTO.self, from: response.data)
                return res.toEntity()
            }.asObservable()
            .catch { error in
                print("fetchError")
                print(error)
                return Observable.error(error)
            }.asObservable()
    }
}
