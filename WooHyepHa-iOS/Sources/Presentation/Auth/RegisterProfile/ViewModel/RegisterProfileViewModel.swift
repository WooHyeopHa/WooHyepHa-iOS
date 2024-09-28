//
//  RegisterProfileViewModel.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 9/28/24.
//

import RxSwift
import RxCocoa

final class RegisterProfileViewModel: ViewModelType {
    struct Input {
        let disableButtonTapped: Observable<Void>
        let backButtonTapped: Observable<Void>
        let profileImageURL: Observable<String>
        let birth: Observable<String>
        let sex: Observable<String>
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
        // 중복이 아니거나, 텍스트 필드가 공백이면 안됨.
        let isBirthEmpty = BehaviorSubject<Bool>(value: true)
        let isSexEmpty = BehaviorSubject<Bool>(value: true)
        let isValid = BehaviorSubject<Bool>(value: false)
        
        Observable.combineLatest(isBirthEmpty, isSexEmpty)
            .subscribe(with: self, onNext: { owner, boolean in
                let isEmpty = !boolean.0 && !boolean.1
                isValid.onNext(isEmpty)
            })
            .disposed(by: disposeBag)
        
        input.backButtonTapped
            .subscribe(with: self, onNext: { owner, _ in
                owner.coordinator?.pop()
            })
            .disposed(by: disposeBag)
        
        input.disableButtonTapped
            .subscribe(with: self, onNext: { owner, _ in
                owner.coordinator?.goToRegisterLocationViewController()
                input.profileImageURL.subscribe(onNext: { url in print(url)}).disposed(by: owner.disposeBag)
                input.birth.subscribe(onNext: { birth in print(birth)}).disposed(by: owner.disposeBag)
                input.sex.subscribe(onNext: { sex in print(sex)}).disposed(by: owner.disposeBag)
            })
            .disposed(by: disposeBag)
        
        return Output(
            isDisableButtonEnabled: isValid.asDriver(onErrorDriveWith: .empty())
        )
    }
}
