//
//  TokenPlugin.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 11/29/24.
//

import Foundation
import Moya
import RxSwift

protocol AuthorizedTargetType: TargetType {
    var requiresAuthentication: Bool { get }
}

class TokenPlugin: PluginType {
    private let tokenStorage = TokenStorage.shared
    private let disposeBag = DisposeBag()
    private var isRefreshing = false
    
    // 요청 전 액세스 토큰 추가
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        
        if let authTarget = target as? AuthService, case .refreshToken = authTarget {
            if let accessToken = try? tokenStorage.loadToken(type: .access) {
                request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            }
            return request
        }
            
        guard let authorizedTarget = target as? AuthorizedTargetType,
              authorizedTarget.requiresAuthentication,
              let accessToken = try? tokenStorage.loadToken(type: .access) else {
            return request
        }

        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        return request
    }
    
    // 응답 처리 (401)
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        print("didReceive called with result:", result)
        
        // success case에서도 401 체크
        let statusCode = switch result {
            case .success(let response): response.statusCode
            case .failure(let error): error.response?.statusCode
        }
        
        guard statusCode == 401,
              let authorizedTarget = target as? AuthorizedTargetType,
              authorizedTarget.requiresAuthentication else {
            print("didReceive guard failed")
            return
        }
        
        print("토큰 만료")
        handleTokenRefresh()
    }
    
    private func handleTokenRefresh() {
        print("토큰 재발급 시도")
        guard !isRefreshing else { return }
        isRefreshing = true
        
        let provider = MoyaProvider<AuthService>()
        provider.rx.request(.refreshToken)
            .subscribe(onSuccess: { [weak self] response in
                guard let self = self else { return }
                
                if let newAccessToken = response.response?.allHeaderFields["Authorization"] as? String {
                    try? self.tokenStorage.saveToken(newAccessToken, type: .access)
                }
                
                self.isRefreshing = false
            }, onFailure: { [weak self] error in
                guard let self = self else { return }
                
                if let moyaError = error as? MoyaError,
                   moyaError.response?.statusCode == 401 {
                    self.handleLogout()
                }
                
                self.isRefreshing = false
            })
            .disposed(by: disposeBag)
    }
    
    private func handleLogout() {
         try? tokenStorage.deleteAllTokens()
         NotificationCenter.default.post(
             name: NSNotification.Name("UserDidLogout"),
             object: nil
         )
     }
}

