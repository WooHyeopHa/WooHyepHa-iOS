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
        let nextButtonTapped: Observable<Void>
    }
    
    struct Output { }
    
    let disposeBag = DisposeBag()
    weak var coordinator: AuthCoordinator?
    
    init(coordinator: AuthCoordinator) {
        self.coordinator = coordinator
    }
    
    func bind(input: Input) -> Output {
        return Output()
    }
}
