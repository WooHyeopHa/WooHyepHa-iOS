//
//  HomeViewModel.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/11/24.
//

import RxSwift
import RxCocoa

final class HomeViewModel: ViewModelType {
    struct Input {
        let calendarButtonTapped: Observable<Void>
        let exhibitionButtonTapped: Observable<Void>
        let concertButtonTapped: Observable<Void>
        let classicButtonTapped: Observable<Void>
        let musicalButtonTapped: Observable<Void>
        
        let alarmButtonTapped: Observable<Void>
    }
    
    struct Output {
        let mockNowHomeData: Driver<NowHome>
    }
    
    let disposeBag = DisposeBag()
    weak var coordinator: HomeCoordinator?
    private let homeUseCase: NowHomeUseCase
    
    init(coordinator: HomeCoordinator, homeUseCase: NowHomeUseCase) {
        self.coordinator = coordinator
        self.homeUseCase = homeUseCase
    }
    
    func bind(input: Input) -> Output {
        let mockNowHomeData = BehaviorRelay<NowHome>(value:NowHome.init(status: "", data: .init(artRandomList: [], artTodayRandom: ArtTodayRandom(title: "", startDate: "", endDate: "")), message: ""))
        
        input.calendarButtonTapped
            .subscribe(with: self, onNext: { owner, _ in
                owner.coordinator?.goToCultureCalendarViewController()
            })
            .disposed(by: disposeBag)
        
        input.exhibitionButtonTapped
            .subscribe(with: self, onNext: { owner, _ in
                
            })
            .disposed(by: disposeBag)
        
        input.alarmButtonTapped
            .subscribe(with: self, onNext: { owner, _ in
                owner.coordinator?.goToAlarmViewController()
            })
            .disposed(by: disposeBag)
        
        homeUseCase.fetchMockNowHome()
            .subscribe(with: self, onNext: { owner, data in
                mockNowHomeData.accept(data)
            })
            .disposed(by: disposeBag)
        
        return Output(
            mockNowHomeData: mockNowHomeData.asDriver()
        )
    }
}
