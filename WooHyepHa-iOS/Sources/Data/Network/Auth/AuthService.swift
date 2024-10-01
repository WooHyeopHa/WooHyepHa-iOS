//
//  AuthService.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/26/24.
//

import Moya

public enum AuthService {
    case signInWithApple(SignInWithAppleRequestDTO)
    
    case fetchIsValidNickname(nickname: String)
    case registerNickname(RegisterNicknameRequestDTO)
}

extension AuthService: TargetType {
    public var baseURL: URL {
        return .init(string: "https://findmuse.store")!
    }
    
    public var path: String {
        switch self {
        case .signInWithApple:
            return "/auth/apple/token"
            
        case .fetchIsValidNickname, .registerNickname:
            return "/user/profile/nickname"
        }
    }
    
    public var method: Method {
        switch self {
        case .fetchIsValidNickname:
            return .get
            
        case .signInWithApple, .registerNickname:
            return .post
        }
    }
    
    public var task: Task {
        switch self {
        case .fetchIsValidNickname(let nickname):
            return .requestParameters(parameters: [nickname: nickname], encoding: URLEncoding.queryString)

        case .signInWithApple(let request):
            return .requestJSONEncodable(request)
            
        case .registerNickname(let request):
            return .requestJSONEncodable(request)
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .signInWithApple:
            return ["Content-Type" : "application/json"]
        
        case .fetchIsValidNickname, .registerNickname:
            return ["Content-Type" : "application/json"]
        }
    }
}
