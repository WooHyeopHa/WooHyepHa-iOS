//
//  AuthPlugin.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 11/5/24.
//

import Foundation
import Moya
import RxSwift

final class AuthPlugin: PluginType {
    private let tokenStorage = TokenStorage.shared
    private let authRepository = AuthRepository()
    private let disposeBag = DisposeBag()
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        if let authTarget = target as? AuthService, case .refreshToken = authTarget {
            return request
        }
        
        var request = request
        
        if let accessToken = try? tokenStorage.loadToken(type: .access) {
            request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        return request
    }
}
