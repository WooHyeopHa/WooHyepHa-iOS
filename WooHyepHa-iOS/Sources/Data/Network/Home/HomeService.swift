//
//  HomeService.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/11/24.
//

import Moya

public enum HomeService {
    case fetchNowHome(userId: Int)
}

extension HomeService: TargetType {
    public var baseURL: URL {
        return .init(string: "https://findmuse.store")!
    }
    
    public var path: String {
        switch self {
        case .fetchNowHome(let userId):
            return "/art/home/\(userId)"
        }
    }
    
    public var method: Method {
        switch self {
        case .fetchNowHome:
            return .get
        }
    }
    
    public var task: Task {
        switch self {
        case .fetchNowHome(let userId):
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .fetchNowHome:
            return ["Content-Type" : "application/json"]
        }
    }
}
