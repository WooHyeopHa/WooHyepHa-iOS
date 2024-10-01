//
//  RegisterUseCase.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/1/24.
//

import RxSwift

protocol RegisterUseCaseProtocol {
    func fetchIsValidNickname(nickname: String) -> Observable<Auth>
}

final class RegisterUseCase: RegisterUseCaseProtocol {

    private let authRepository: AuthRepositoryProtocol
    
    init(authRepository: AuthRepositoryProtocol) {
        self.authRepository = authRepository
    }
    
    func fetchIsValidNickname(nickname: String) -> Observable<Auth> {
        authRepository.fetchIsValidNickname(nickname: nickname)
    }
}
