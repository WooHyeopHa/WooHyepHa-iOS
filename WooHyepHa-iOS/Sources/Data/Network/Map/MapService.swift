//
//  MapService.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/23/24.
//

import Moya

public enum MapService {
    case fetchArtMapList
}

extension MapService: TargetType {
    public var baseURL: URL {
        return URL(string: "https://findmuse.store/api")!
    }
    
    public var path: String {
        switch self {
        case .fetchArtMapList:
            return "/v1/map/info"
        }
    }
    
    public var method: Method {
        switch self {
        case .fetchArtMapList:
            return .get
        }
    }
    
    public var task: Task {
        switch self {
        case .fetchArtMapList:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .fetchArtMapList:
            let accessToken = try? TokenStorage.shared.loadToken(type: .access)
            return [
                "Content-Type" : "application/json",
                "Authorization" : "Bearer \(accessToken ?? "")"
            ]
        }
        //return ["Content-Type": "application/json"]
    }
}
