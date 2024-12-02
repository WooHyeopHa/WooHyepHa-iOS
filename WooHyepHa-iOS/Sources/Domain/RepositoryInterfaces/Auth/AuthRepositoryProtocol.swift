//
//  AuthRepositoryProtocol.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/26/24.
//

import RxSwift

protocol AuthRepositoryProtocol {
    func signInWithApple(credentials: SignInWithAppleRequestDTO) -> Observable<Bool>
    func fetchIsValidNickname(nickname: String) -> Observable<Auth>
    func registerNickname(nickname:RegisterNicknameRequestDTO) -> Completable
}
