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
        let mockArtMapListData: Driver<ArtMap>
    }
    
    let disposeBag = DisposeBag()
    
    private let mapUseCase: MapUseCase
    
    init(mapUseCase: MapUseCase) {
        self.mapUseCase = mapUseCase
    }
    
    func bind(input: Input) -> Output {
        let currentLocation = PublishRelay<CLLocationCoordinate2D>()
        let currentStatus = PublishRelay<LocationAuthorizationStatus>()
        let mockArtMapListData = BehaviorRelay<ArtMap>(value: ArtMap(status: "100", data: ArtMapData(artMapList: [ArtMapList(latitude: "", longitude: "", poster: "", title: "", artId: 0, genre: "", place: "", startDate: "", endDate: "")]),message: "요청이 성공적으로 이루어졌습니다."))
        
        mapUseCase.checkUserCurrentLocationAuthorization()
            .subscribe(with: self, onNext: { owner, status in
                print(status)
            })
            .disposed(by: disposeBag)
        
        mapUseCase.getUserLocation()
            .subscribe(with: self, onNext: { owner, status in
                currentLocation.accept(status)
            })
            .disposed(by: disposeBag)
        
        mapUseCase.fetchMockArtMapList()
            .subscribe(onNext: { data in
                mockArtMapListData.accept(data)
            })
            .disposed(by: disposeBag)
        
        return Output (currentLocation: currentLocation.asDriver(
            onErrorDriveWith: .empty()),
            currentStatus: currentStatus.asDriver(onErrorDriveWith: .empty()),
            mockArtMapListData: mockArtMapListData.asDriver()
        )
    }
}
