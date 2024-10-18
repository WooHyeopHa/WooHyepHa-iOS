//
//  LocationService.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/18/24.
//

import CoreLocation
import RxCocoa
import RxSwift

final class LocationService: NSObject {
    
    var locationManager: CLLocationManager?
    private let authorizationStatus = BehaviorSubject<CLAuthorizationStatus>(value: .notDetermined)
    private let locationSubject = PublishSubject<CLLocation>()
    
    var disposeBag = DisposeBag()
    
    override init() {
        super.init()
        
        self.locationManager = CLLocationManager()
        self.locationManager?.delegate = self
        self.locationManager?.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }
    
    func observeUpdateAuthorization() -> Observable<CLAuthorizationStatus> {
        print("상태 확인")
        authorizationStatus.subscribe(onNext: { s in
            print(s)
        }).disposed(by: disposeBag)
        return self.authorizationStatus.asObservable()
    }
    
    func requestAuthorization() {
        print("권한 요청")
        self.locationManager?.requestWhenInUseAuthorization()
    }
    
    func requestLocation() -> Observable<CLLocation> {
        print("리퀘스트 로케이션")
        self.locationManager?.requestLocation()
        return locationSubject.asObservable()
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
          if let location = locations.last {
              locationSubject.onNext(location)
          }
      }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
          locationSubject.onError(error)
      }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus.onNext(manager.authorizationStatus)
    }
}
