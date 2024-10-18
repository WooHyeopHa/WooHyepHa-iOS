//
//  MapUseCase.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/18/24.
//

import RxSwift
import CoreLocation

protocol MapUseCaseProtocol {
    func checkUserCurrentLocationAuthorization() -> Observable<LocationAuthorizationStatus>
    func getUserLocation() -> Observable<CLLocationCoordinate2D>
    //func fetchCultureItem() -> Observable<[Map]>
}

final class MapUseCase: MapUseCaseProtocol {
    private let repository: MapRepositoryProtocol
    
    init(repository: MapRepositoryProtocol) {
        self.repository = repository
    }
    
    func checkUserCurrentLocationAuthorization() -> Observable<LocationAuthorizationStatus> {
        self.repository.checkUserCurrentLocationAuthorization()
        
        return repository.authorizationStatus.asObservable()
    }
    
    func getUserLocation() -> Observable<CLLocationCoordinate2D> {
        return repository.currentUserLocation.asObservable()
    }
    
//    func fetchCultureItem() -> Observable<[Map]> {
//        return repository.fetchCultureItem().asObservable()
//    }
}
