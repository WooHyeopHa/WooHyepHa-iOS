//
//  CultureCalendarViewModel.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/15/24.
//

import RxSwift
import RxCocoa

final class CultureCalendarViewModel: ViewModelType {
    struct Input {
        let nowButtonTapped: Observable<Void>
        let alarmButtonTapped: Observable<Void>
//        let allButtonTapped: Observable<Void>
//        let exhibitionButtonTapped: Observable<Void>
//        let concertButtonTapped: Observable<Void>
//        let classicButtonTapped: Observable<Void>
//        let musicalButtonTapped: Observable<Void>
    }
    
    struct Output {
        let mockCultureCalendarData: Driver<CultureCalendar>
    }
    
    let disposeBag = DisposeBag()
    weak var coordinator: HomeCoordinator?
    private let cultureCalendarUseCase: CultureCalendarUseCase
    
    init(coordinator: HomeCoordinator, cultureCalendarUseCase: CultureCalendarUseCase) {
        self.coordinator = coordinator
        self.cultureCalendarUseCase = cultureCalendarUseCase
    }
    
    func bind(input: Input) -> Output {
        let mockCultureCalendarData = BehaviorRelay<CultureCalendar>(value: CultureCalendar(status: "100", data: CultureCalendarData(artList: [ArtList(title: "", place: "", genre: "", poster: "", startDate: "", endDate: "", liked: false)]),message: "요청이 성공적으로 이루어졌습니다."))
        
        input.nowButtonTapped
            .subscribe(with: self, onNext: { owner, _ in
                owner.coordinator?.pop(animated: false)
            })
            .disposed(by: disposeBag)
        
        input.alarmButtonTapped
            .subscribe(with: self, onNext: { owner, _ in
                owner.coordinator?.goToAlarmViewController()
            })
            .disposed(by: disposeBag)
        
        cultureCalendarUseCase.fetchMockCultureCalendar()
            .subscribe(with: self, onNext: { owner, data in
                mockCultureCalendarData.accept(data)
            })
            .disposed(by: disposeBag)
        
        return Output(
            mockCultureCalendarData: mockCultureCalendarData.asDriver()
        )
    }
}
