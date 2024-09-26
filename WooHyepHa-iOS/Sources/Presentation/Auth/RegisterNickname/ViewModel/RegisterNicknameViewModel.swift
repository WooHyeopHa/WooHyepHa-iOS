//
//  RegisterNicknameViewModel.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 9/25/24.
//

import RxSwift
import RxCocoa

final class RegisterNicknameViewModel: ViewModelType {
    struct Input {
        let disableButtonTapped: Observable<Void>
        let nickName: Observable<String>
    }
    
    struct Output { }
    
    let disposeBag = DisposeBag()
    weak var coordinator: AuthCoordinator?
    
    init(coordinator: AuthCoordinator) {
        self.coordinator = coordinator
    }
    
    func bind(input: Input) -> Output {
        input.nickName
            .subscribe(onNext:  { name in
                print(name)
            })
            .disposed(by: disposeBag)
        
        input.disableButtonTapped
            .subscribe(with: self, onNext: { owner, _ in
                owner.coordinator?.goToSignUpViewController()
            })
            .disposed(by: disposeBag)
        return Output()
    }
}
