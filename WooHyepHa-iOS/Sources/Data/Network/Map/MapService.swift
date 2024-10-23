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
        return URL(string: "https://findmuse.store")!
    }
    
    public var path: String {
        switch self {
        case .fetchArtMapList:
            return "/map/info"
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
        return ["Content-Type": "application/json"]
    }
}
