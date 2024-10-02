//
//  AuthRepository.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/26/24.
//

import AuthenticationServices
import RxSwift
import Moya

final class AuthRepository: NSObject, AuthRepositoryProtocol {
    
    private let service = MoyaProvider<AuthService>()
    private var appleLoginEmitter: AnyObserver<(String, String)>?
    
    func signInWithApple(credentials: SignInWithAppleRequestDTO) -> Observable<Bool> {
        return service.rx.request(.signInWithApple(credentials))
            .filterSuccessfulStatusCodes()
            .map { response in
                print("상태 코드: \(response.statusCode)")
                let res = try JSONDecoder().decode(SignInWithAppleResponsesDTO.self, from: response.data)
                print("결과: \(res)")
                return false
            }
            .catch { error in
                if let moyaError = error as? MoyaError {
                    switch moyaError {
                    case .statusCode(let response):
                        print("에러 상태 코드: \(response.statusCode)")
                    default:
                        print("Moya 에러: \(moyaError.localizedDescription)")
                    }
                } else {
                    print("기타 에러: \(error.localizedDescription)")
                }
                return .error(error)
            }
            .asObservable()
    }
    
    func fetchIsValidNickname(nickname: String) -> Observable<Auth> {
        return service.rx.request(.fetchIsValidNickname(nickname: nickname))
            .filterSuccessfulStatusCodes()
            .map { response -> Auth in
                print("상태 코드 : \(response.statusCode)")
                let res = try JSONDecoder().decode(RegisterNicknameResponsesDTO.self, from: response.data)
                return res.toEntity()
            }.asObservable()
            .catch { error in
                print("fetchError")
                return Observable.error(error)
            }
    }
}
