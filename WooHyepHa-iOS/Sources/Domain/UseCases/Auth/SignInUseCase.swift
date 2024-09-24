//
//  SignInUseCase.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/26/24.
//

import RxSwift

protocol SignInUseCaseProtocol {
    func signInWithApple(credentials: SignInWithAppleRequestDTO) -> Observable<SignInResult>
}

final class SignInUseCase: SignInUseCaseProtocol {
    
    private let authRepository: AuthRepositoryProtocol
    
    init(authRepository: AuthRepositoryProtocol) {
        self.authRepository = authRepository
    }
    
    func signInWithApple(credentials: SignInWithAppleRequestDTO) -> Observable<SignInResult> {
        authRepository.signInWithApple(credentials: credentials)
            .map { isRegistered in
                isRegistered ? .success : .signUpNeeded
            }
            .catchAndReturn(.failure)
    }
}
