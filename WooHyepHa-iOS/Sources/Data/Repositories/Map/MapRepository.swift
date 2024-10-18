//
//  MapRepository.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/18/24.
//

import RxSwift
import CoreLocation

final class MapRepository: MapRepositoryProtocol {
    
    private let disposeBag = DisposeBag()
    
    private let locationService = LocationService()
    
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
    
//    func fetchCultureItem() -> Observable<[Map]> {
//        return Observable.just(mockCultureItems.map { $0.toEntity()} )
//    }
    
    private func requestUserLocation() {
        self.locationService.requestLocation()
            .take(1)
            .subscribe(with: self, onNext: { owner, location in
                owner.currentUserLocation.onNext(location.coordinate)
            })
            .disposed(by: disposeBag)
      }
}
