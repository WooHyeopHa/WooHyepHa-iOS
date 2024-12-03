//
//  AuthService.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/26/24.
//

import Moya

public enum AuthService {
    case refreshAccessToken(refreshToken: String)
    case refreshToken(refreshToken: String)
    case signInWithApple(SignInWithAppleRequestDTO)
    case fetchIsValidNickname(nickname: String)
    case registerNickname(RegisterNicknameRequestDTO)
}

extension AuthService: AuthorizedTargetType {
    var requiresAuthentication: Bool {
        switch self {
        case .signInWithApple, .refreshToken, .refreshAccessToken:
            return false
            
        case .fetchIsValidNickname, .registerNickname:
            return true
        }
    }
}


extension AuthService: TargetType {
    public var baseURL: URL {
        return .init(string: "https://findmuse.store/api")!
    }
    
    public var path: String {
        switch self {
        case .refreshToken:
            return "/jwt/refresh-token"

        case .refreshAccessToken:
            return "/jwt/access-token"
            
        case .signInWithApple:
            return "/auth/apple/token"
            
        case .fetchIsValidNickname, .registerNickname:
            return "/user/profile/nickname"
        }
    }
    
    public var method: Method {
        switch self {
        case .refreshToken, .refreshAccessToken:
            return .patch
            
        case .fetchIsValidNickname:
            return .get
            
        case .signInWithApple, .registerNickname:
            return .post
        }
    }
    
    public var task: Task {
        switch self {
        case .refreshToken(let refreshToken):
            return .requestParameters(
                parameters: ["refreshTokenDto": refreshToken],
                encoding: URLEncoding.queryString
            )
        
        case .refreshAccessToken(let refreshToken):
            return .requestParameters(
                parameters: ["refreshToken": refreshToken],
                encoding: URLEncoding.queryString
            )
            
        case .fetchIsValidNickname(let nickname):
            return .requestParameters(
                parameters: ["nickname": nickname],
                encoding: URLEncoding.queryString
            )

        case .signInWithApple(let request):
            return .requestJSONEncodable(request)
            
        case .registerNickname(let nickname):
            return .requestParameters(
                parameters: ["nickname" : nickname.nickName ?? ""], 
                encoding: JSONEncoding.default
            )
        }
    }

    public var headers: [String: String]? {
        return ["Content-Type": "application/json"]
        // 리프레시 토큰은 더 이상 헤더로 보내지 않으므로 case 삭제
    }
}

