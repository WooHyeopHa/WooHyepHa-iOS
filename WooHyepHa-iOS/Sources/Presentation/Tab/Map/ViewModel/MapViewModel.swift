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
        let infoButtonTapped: Observable<Int>
    }
    
    struct Output {
        let currentLocation: Driver<CLLocationCoordinate2D>
        let currentStatus: Driver<LocationAuthorizationStatus>
        let artMapListData: Driver<ArtMap>
    }
    
    let disposeBag = DisposeBag()
    weak var coordinator: MapCoordinator?
    private let mapUseCase: MapUseCase
    
    init(coordinator: MapCoordinator, mapUseCase: MapUseCase) {
        self.mapUseCase = mapUseCase
        self.coordinator = coordinator
    }
    
    func bind(input: Input) -> Output {
        let currentLocation = PublishRelay<CLLocationCoordinate2D>()
        let currentStatus = PublishRelay<LocationAuthorizationStatus>()
        let artMapListData = BehaviorRelay<ArtMap>(value: ArtMap(status: "100", data: ArtMapData(artMapList: [ArtMapList(latitude: "", longitude: "", poster: "", title: "", artId: 0, genre: "", place: "", startDate: "", endDate: "")]),message: "요청이 성공적으로 이루어졌습니다."))
        
        input.infoButtonTapped
            .subscribe(with: self, onNext: { owner, artId in
                owner.coordinator?.goToDetailInfoViewController(artId: artId)
            })
            .disposed(by: disposeBag)
        
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
        
        mapUseCase.fetchArtMapList()
            .subscribe(with: self, onNext: { owner, data in
                artMapListData.accept(data)
            })
            .disposed(by: disposeBag)
        
//        mapUseCase.fetchMockArtMapList()
//            .subscribe(onNext: { data in
//                mockArtMapListData.accept(data)
//            })
//            .disposed(by: disposeBag)
        
        return Output (currentLocation: currentLocation.asDriver(
            onErrorDriveWith: .empty()),
            currentStatus: currentStatus.asDriver(onErrorDriveWith: .empty()),
            artMapListData: artMapListData.asDriver()
        )
    }
}
