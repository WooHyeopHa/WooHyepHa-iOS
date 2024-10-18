//
//  MapViewModel.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/18/24.
//

import RxSwift
import RxCocoa
import CoreLocation

// 뷰모델 타입
final class MapViewModel: ViewModelType {
    struct Input {
    }
    
    struct Output {
        let currentLocation: Driver<CLLocationCoordinate2D>
        let currentStatus: Driver<LocationAuthorizationStatus>
        //let cultureItem: Driver<[Map]>
    }
    
    let disposeBag = DisposeBag()
    
    private let mapUseCase: MapUseCase
    
    init(mapUseCase: MapUseCase) {
        self.mapUseCase = mapUseCase
    }
    
    func bind(input: Input) -> Output {
        let currentLocation = PublishRelay<CLLocationCoordinate2D>()
        let currentStatus = PublishRelay<LocationAuthorizationStatus>()
        //let cultureItem = BehaviorRelay<[Map]>(value: [])
        
        mapUseCase.checkUserCurrentLocationAuthorization()
            .subscribe(with: self, onNext: { owner, status in
                print("v")
                print(status)
            })
            .disposed(by: disposeBag)
        
        mapUseCase.getUserLocation()
            .subscribe(with: self, onNext: { owner, status in
                currentLocation.accept(status)
            })
            .disposed(by: disposeBag)
        
//        mapUseCase.fetchCultureItem()
//            .subscribe(with: self, onNext: { owner, item in
//                cultureItem.accept(item)
//            })
//            .disposed(by: disposeBag)
        
        return Output (currentLocation: currentLocation.asDriver(
            onErrorDriveWith: .empty()),
            currentStatus: currentStatus.asDriver(onErrorDriveWith: .empty())
           //cultureItem: cultureItem.asDriver()
        )
    }
}
