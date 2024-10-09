//
//  SignUpViewModel.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 9/28/24.
//

import RxSwift
import RxCocoa

final class SignUpViewModel: ViewModelType {
    struct Input {
        let backButtonTapped: Observable<Void>
        let nextButtonTapped: Observable<Void>
    }
    
    struct Output { }
    
    let disposeBag = DisposeBag()
    weak var coordinator: AuthCoordinator?
    
    init(coordinator: AuthCoordinator) {
        self.coordinator = coordinator
    }
    
    func bind(input: Input) -> Output {
        
        input.backButtonTapped
            .subscribe(with: self, onNext: { owner, _ in
                owner.coordinator?.pop(animated: true)
            })
            .disposed(by: disposeBag)
        
        input.nextButtonTapped
            .subscribe(with: self, onNext: { owner, _ in
                owner.coordinator?.goToRegisterProfileViewController()
            })
            .disposed(by: disposeBag)
        return Output()
    }
}
