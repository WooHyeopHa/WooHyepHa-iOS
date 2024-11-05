//
//  AuthService.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/26/24.
//

import Moya

public enum AuthService {
    case refreshToken
    case signInWithApple(SignInWithAppleRequestDTO)
    case fetchIsValidNickname(nickname: String)
    case registerNickname(RegisterNicknameRequestDTO)
    private static let tokenStorage = TokenStorage.shared
}

extension AuthService: TargetType {
    public var baseURL: URL {
        return .init(string: "https://findmuse.store/api")!
    }
    
    public var path: String {
        switch self {
        case .refreshToken:
            return "/jwt/refresh"
            
        case .signInWithApple:
            return "/auth/apple/token"
            
        case .fetchIsValidNickname, .registerNickname:
            return "/user/profile/nickname"
        }
    }
    
    public var method: Method {
        switch self {
        case .refreshToken:
            return .patch
            
        case .fetchIsValidNickname:
            return .get
            
        case .signInWithApple, .registerNickname:
            return .post
        }
    }
    
    public var task: Task {
        switch self {
        case .refreshToken:
            let refreshToken = try? AuthService.tokenStorage.loadToken(type: .refresh)
            return .requestParameters(
                parameters: ["refreshToken": refreshToken],
                encoding: JSONEncoding.default
            )
            
        case .fetchIsValidNickname(let nickname):
            return .requestParameters(
                parameters: ["nickname": nickname],
                encoding: URLEncoding.queryString
            )

        case .signInWithApple(let request):
            return .requestJSONEncodable(request)
            
        case .registerNickname(let request):
            return .requestJSONEncodable(request)
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .signInWithApple, .refreshToken:
            return ["Content-Type" : "application/json"]
        
        case .fetchIsValidNickname, .registerNickname:
            let accessToken = try? AuthService.tokenStorage.loadToken(type: .access)
            return [
                "Content-Type" : "application/json",
                "Authorization" : "Bearer \(accessToken ?? "")"
            ]
        }
    }
}
