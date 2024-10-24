//
//  RxASAuthorizationControllerDelegateProxy.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/26/24.
//

import AuthenticationServices
import RxCocoa
import RxSwift

// MARK: - Proxy
class RxASAuthorizationControllerDelegateProxy:
    DelegateProxy<ASAuthorizationController, ASAuthorizationControllerDelegate>,
    DelegateProxyType {
    
    var didComplete = PublishSubject<ASAuthorization>()
    
    init(controller: ASAuthorizationController) {
        super.init(parentObject: controller, delegateProxy: RxASAuthorizationControllerDelegateProxy.self)
    }
    
    deinit { didComplete.onCompleted() }
    
    static func registerKnownImplementations() {
        register { RxASAuthorizationControllerDelegateProxy(controller: $0) }
    }
    
    static func currentDelegate(for object: ASAuthorizationController) -> ASAuthorizationControllerDelegate? {
        object.delegate
    }
    
    static func setCurrentDelegate(_ delegate: ASAuthorizationControllerDelegate?, to object: ASAuthorizationController) {
        object.delegate = delegate
    }
}

// MARK: - Delegate
extension RxASAuthorizationControllerDelegateProxy: ASAuthorizationControllerDelegate {
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        didComplete.onNext(authorization)
        didComplete.onCompleted()
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        if (error as NSError).code == ASAuthorizationError.canceled.rawValue {
            didComplete.onCompleted()
            return
        }
        
        didComplete.onError(error)
    }
}

// MARK: - Reactive
extension Reactive where Base: ASAuthorizationController {
    public var didComplete: Observable<ASAuthorization> {
        RxASAuthorizationControllerDelegateProxy.proxy(for: base).didComplete.asObservable()
    }
}

extension Reactive where Base: ASAuthorizationAppleIDProvider {
    public func requestAuthorizationWithAppleID() -> Observable<ASAuthorization> {
        let appleIDProvider = base
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.performRequests()
        return authorizationController.rx.didComplete
    }
}
