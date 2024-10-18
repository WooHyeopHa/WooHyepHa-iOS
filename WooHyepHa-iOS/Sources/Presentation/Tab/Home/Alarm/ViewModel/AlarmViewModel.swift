//
//  AlarmViewModel.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/18/24.
//

import RxSwift
import RxCocoa

final class AlarmViewModel: ViewModelType {
    struct Input {
        let backButtonTapped: Observable<Void>
    }
    
    struct Output {
    
    }
    
    let disposeBag = DisposeBag()
    weak var coordinator: HomeCoordinator?
    private let homeUseCase: NowHomeUseCase
    
    init(coordinator: HomeCoordinator, homeUseCase: NowHomeUseCase) {
        self.coordinator = coordinator
        self.homeUseCase = homeUseCase
    }
    
    func bind(input: Input) -> Output {
        input.backButtonTapped
            .subscribe(with: self, onNext: { owner, _ in
                owner.coordinator?.pop(animated: false)
            })
            .disposed(by: disposeBag)
        
        return Output(
        )
    }
}
