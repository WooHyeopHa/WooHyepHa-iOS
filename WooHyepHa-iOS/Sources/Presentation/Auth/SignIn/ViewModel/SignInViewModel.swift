//
//  SignInViewModel.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/26/24.
//

import AuthenticationServices
import RxSwift
import RxCocoa

final class SignInViewModel: ViewModelType {
    struct Input {
        let signInWithAppleButtonTapped: Observable<Void>
    }
    
    struct Output { }
    
    let disposeBag = DisposeBag()
    weak var coordinator: AuthCoordinator?
    private let signInUseCase: SignInUseCase
    
    init(coordinator: AuthCoordinator, signInUseCase: SignInUseCase) {
        self.coordinator = coordinator
        self.signInUseCase = signInUseCase
    }
    
    func bind(input: Input) -> Output {
        input.signInWithAppleButtonTapped
            .flatMap {
                ASAuthorizationAppleIDProvider().rx.requestAuthorizationWithAppleID()
            }
            .withUnretained(self)
            .map { owner, authorization in
                owner.mapToUserCredentials(authorization)
            }
            .withUnretained(self)
            .flatMap { owner, credentials in
                owner.signInUseCase.signInWithApple(credentials: credentials)
            }
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .subscribe(onNext: { owner, result in
                switch result {
                case .signUpNeeded:
                    print("가입 필요")
                    owner.coordinator?.goToRegisterNicknameViewController()
                case .success:
                    print("성공")
                case .failure:
                    print("실패1")
                }
            })
            .disposed(by: disposeBag)
        return Output()
    }
}

private extension SignInViewModel {
    func mapToUserCredentials(_ authorization: ASAuthorization) -> SignInWithAppleRequestDTO {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            return SignInWithAppleRequestDTO(code: "", id_token: "")
        }
        
        let identityToken = String(data: appleIDCredential.identityToken ?? Data(), encoding: .utf8)
        let authorizationCode = String(data: appleIDCredential.authorizationCode ?? Data(), encoding: .utf8)
        
        //print(authorizationCode!)
        //print(identityToken!)
        return SignInWithAppleRequestDTO(
            code: authorizationCode!, id_token: identityToken!
        )
    }
}
