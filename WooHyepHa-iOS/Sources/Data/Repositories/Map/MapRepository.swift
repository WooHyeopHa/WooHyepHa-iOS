//
//  MapRepository.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/18/24.
//

import RxSwift
import Moya
import CoreLocation

final class MapRepository: MapRepositoryProtocol {
    
    private let disposeBag = DisposeBag()
    
    private let locationService = LocationService()
    private let service = MoyaProvider<MapService>(plugins: [TokenPlugin()])
    
    var currentUserLocation = PublishSubject<CLLocationCoordinate2D>()
    var authorizationStatus = PublishSubject<LocationAuthorizationStatus>()
    
    init() { }
    
    func checkUserCurrentLocationAuthorization() {
        self.locationService.observeUpdateAuthorization()
            .subscribe(with: self, onNext: { owner, status in
                switch status {
                case .notDetermined:
                    owner.locationService.requestAuthorization()
                case .authorizedAlways, .authorizedWhenInUse:
                    owner.authorizationStatus.onNext(.allowed)
                    owner.requestUserLocation()
                case .denied, .restricted:
                    owner.authorizationStatus.onNext(.disallowed)
                default:
                    owner.authorizationStatus.onNext(.notDetermined)
                }
            })
            .disposed(by: disposeBag)
    }
    
    func fetchArtMapList() -> Observable<ArtMap> {
        return service.rx.request(.fetchArtMapList)
            .filterSuccessfulStatusCodes()
            .map { response -> ArtMap in
                print("상태 코드 : \(response.statusCode)")
                let res = try JSONDecoder().decode(ArtMapResponsesDTO.self, from: response.data)
                return res.toEntity()
            }.asObservable()
            .catch { error in
                print("fetchError")
                return Observable.error(error)
            }.asObservable()
    }
    
    func fetchMockArtMapList() -> Observable<ArtMap> {
        .just(ArtMapResponsesDTO.testData.toEntity())
    }
    
    private func requestUserLocation() {
        self.locationService.requestLocation()
            .take(1)
            .subscribe(with: self, onNext: { owner, location in
                owner.currentUserLocation.onNext(location.coordinate)
            })
            .disposed(by: disposeBag)
      }
}
