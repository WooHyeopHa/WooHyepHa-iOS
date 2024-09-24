//
//  AuthService.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/26/24.
//

import Moya

public enum AuthService {
    case signInWithApple(SignInWithAppleRequestDTO)
}

extension AuthService: TargetType {
    public var baseURL: URL {
        return .init(string: "https://findmuse.store")!
    }
    
    public var path: String {
        switch self {
        case .signInWithApple:
            return "/auth/apple/token"
        }
    }
    
    public var method: Method {
        switch self {
        case .signInWithApple:
            return .post
        }
    }
    
    public var task: Task {
        switch self {
        case .signInWithApple(let request):
            return .requestJSONEncodable(request)
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .signInWithApple:
            return ["Content-Type" : "application/json"]
        }
    }
}
