//
//  TokenPlugin.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 11/29/24.
//

import Foundation
import Moya
import RxSwift

struct ErrorResponse: Decodable {
    let status: String
    let data: String?
    let message: String
}

protocol AuthorizedTargetType: TargetType {
    var requiresAuthentication: Bool { get }
}

class TokenPlugin: PluginType {
    private let tokenStorage = TokenStorage.shared
    private let disposeBag = DisposeBag()
    private var isRefreshing = false
    private var isAccessTokenExpired = false
    
    // 요청 전 토큰 추가
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        
        print("Current API Target:", target) // 현재 요청하는 target 출력
        
        // 일반 API 요청의 경우, 인증 정보가 필요 없으므로 헤더 처리 불필요
        guard let authorizedTarget = target as? AuthorizedTargetType,
              authorizedTarget.requiresAuthentication else {
            print("⚪️ 인증이 필요없는 일반 API 요청")
            return request
        }
        
        // 인증이 필요한 일반 API 요청의 경우, 인증 정보가 필요하므로 헤더 처리가 필요함
        print("🔑 인증이 필요한 일반 API 요청")
        
        if let accessToken = try? tokenStorage.loadToken(type: .access) {
            request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }

        return request
    }
    
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        let statusCode = switch result {
            case .success(let response): response.statusCode
            case .failure(let error): error.response?.statusCode ?? 0
        }
        
        let data = switch result {
        case .success(let response): response.data
        case .failure(let error): error.response?.data
        }
        
        guard statusCode == 401,
              let response = try? JSONDecoder().decode(ErrorResponse.self, from: data ?? Data() ) else {
            return
        }
        
        switch response.message {
        case "ACCESS_TOKEN_EXPIRED":
            refreshAccessToken()
        case "REFRESH_TOKEN_EXPIRED":
            handleRefreshTokenRefresh()
            print("리프레시 만료")
        default:
            print("기타 에러:", response.message)
        }
    }

    private func refreshAccessToken() {
        guard let refreshToken = try? tokenStorage.loadToken(type: .refresh) else { return }
        print(refreshToken)
        let provider = MoyaProvider<AuthService>()
        provider.rx.request(.refreshAccessToken(refreshToken: refreshToken))
            .filterSuccessfulStatusCodes()
            .map { response -> String in
                let res = try JSONDecoder().decode(RefreshAccessTokenResponseDTO.self, from: response.data)
                print(res)
                return res.data.accessToken
            }
            .subscribe(onSuccess: { [weak self] newAccessToken in
                try? self?.tokenStorage.saveToken(newAccessToken, type: .access)
            }, onFailure: { error in
                print("액세스 토큰 재발급 실패:", error)
            })
            .disposed(by: disposeBag)
    }
    
    private func handleRefreshTokenRefresh() {
        print("리프레시 토큰 재발급 시도")
        guard !isRefreshing,
              let oldRefreshToken = try? tokenStorage.loadToken(type: .refresh) else {
            return
        }
        isRefreshing = true
        
        let provider = MoyaProvider<AuthService>()
        provider.rx.request(.refreshToken(refreshToken: oldRefreshToken))
            .subscribe(onSuccess: { [weak self] response in
                guard let self = self else { return }
                
                // 새로운 리프레시 토큰 저장
                if let newRefreshToken = response.response?.allHeaderFields["Authorization-refresh"] as? String {
                    try? self.tokenStorage.saveToken(newRefreshToken, type: .refresh)
                }
                
                self.isRefreshing = false
            }, onFailure: { [weak self] error in
                guard let self = self else { return }
                
                if let moyaError = error as? MoyaError,
                   moyaError.response?.statusCode == 401 {
                    //self.handleLogout()
                }
                
                self.isRefreshing = false
            })
            .disposed(by: disposeBag)
    }
}
