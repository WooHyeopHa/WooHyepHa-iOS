//
//  MapRepositoryProtocol.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/18/24.
//

import RxSwift
import CoreLocation

protocol MapRepositoryProtocol {
    var authorizationStatus: PublishSubject<LocationAuthorizationStatus> { get }
    var currentUserLocation: PublishSubject<CLLocationCoordinate2D> { get }
    
    func checkUserCurrentLocationAuthorization()
}

