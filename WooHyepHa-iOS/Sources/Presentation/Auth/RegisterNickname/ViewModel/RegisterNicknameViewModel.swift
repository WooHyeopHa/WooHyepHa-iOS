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
    
    struct Output {
        let isNextButtonEnabled: Driver<Bool>
        let isHandleDuplicateEnabled: Driver<Bool>
    }
    
    let disposeBag = DisposeBag()
    weak var coordinator: AuthCoordinator?
    
    init(coordinator: AuthCoordinator) {
        self.coordinator = coordinator
    }
    
    func bind(input: Input) -> Output {
        // 중복이 아니거나, 텍스트 필드가 공백이면 안됨.
        let isNickNameDuplicate = BehaviorSubject<Bool>(value: false)
        let isNickNameEmpty = BehaviorSubject<Bool>(value: true)
        let isNickNameValid = BehaviorSubject<Bool>(value: false)

        input.nickName
            .subscribe(onNext:  { name in
                print(">>>\(name)")
            })
            .disposed(by: disposeBag)
        
        input.nickName
            .subscribe(with: self, onNext: { owner, name in
                isNickNameEmpty.onNext(name.isEmpty)
            })
            .disposed(by: disposeBag)
        
        // 나중에 백에서 중복 여부 받아옴.
        input.nickName
            .subscribe(with: self, onNext: { owner, name in
                if name == "중복" {
                    isNickNameDuplicate.onNext(true)
                } else {
                    isNickNameDuplicate.onNext(false)
                }
            })
            .disposed(by: disposeBag)
        
        Observable.combineLatest(isNickNameDuplicate, isNickNameEmpty)
            .subscribe(with: self, onNext: { owner, boolean in
                let isValid = !boolean.0 && !boolean.1
                isNickNameValid.onNext(isValid)
            })
            .disposed(by: disposeBag)
        
        input.disableButtonTapped
            .subscribe(with: self, onNext: { owner, _ in
                owner.coordinator?.goToSignUpViewController()
            })
            .disposed(by: disposeBag)
        
        return Output(
            isNextButtonEnabled: isNickNameValid.asDriver(onErrorDriveWith: .empty()),
            isHandleDuplicateEnabled: isNickNameDuplicate.asDriver(onErrorDriveWith: .empty())
        )
    }
}
