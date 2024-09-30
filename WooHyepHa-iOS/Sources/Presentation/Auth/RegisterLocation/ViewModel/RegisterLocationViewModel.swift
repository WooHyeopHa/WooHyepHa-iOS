//
//  RegisterLocationViewModel.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 9/30/24.
//

import RxSwift
import RxCocoa

final class RegisterLocationViewModel: ViewModelType {
    struct Input {
        let disableButtonTapped: Observable<Void>
        let backButtonTapped: Observable<Void>
        let location: Observable<String>
    }
    
    struct Output {
        let isDisableButtonEnabled: Driver<Bool>
    }
    
    let disposeBag = DisposeBag()
    weak var coordinator: AuthCoordinator?
    
    init(coordinator: AuthCoordinator) {
        self.coordinator = coordinator
    }
    
    func bind(input: Input) -> Output {
        let isLocationValid = BehaviorSubject<Bool>(value: false)
        
        input.location
            .subscribe(with: self, onNext: { owner, location in
                isLocationValid.onNext(!location.isEmpty)
            })
            .disposed(by: disposeBag)
        
        input.backButtonTapped
            .subscribe(with: self, onNext: { owner, _ in
                owner.coordinator?.pop()
            })
            .disposed(by: disposeBag)
        
        input.disableButtonTapped
            .subscribe(with: self, onNext: { owner, _ in
                owner.coordinator?.goToRegisterPreferenceViewController()
            })
            .disposed(by: disposeBag)
        
        return Output(
            isDisableButtonEnabled: isLocationValid.asDriver(onErrorDriveWith: .empty())
        )
    }
}
