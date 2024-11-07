//
//  MapService.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/23/24.
//

import Moya

public enum MapService {
    case fetchArtMapList
    case fetchDetailArtInfo(artId: Int)
}

extension MapService: TargetType {
    public var baseURL: URL {
        return URL(string: "https://findmuse.store/api")!
    }
    
    public var path: String {
        switch self {
        case .fetchArtMapList:
            return "/v1/map/info"
        case .fetchDetailArtInfo(let artId):
            return "/v1/art/one/\(artId)"
        }
    }
    
    public var method: Method {
        switch self {
        case .fetchArtMapList, .fetchDetailArtInfo:
            return .get
        }
    }
    
    public var task: Task {
        switch self {
        case .fetchArtMapList, .fetchDetailArtInfo:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .fetchArtMapList, .fetchDetailArtInfo:
            let accessToken = try? TokenStorage.shared.loadToken(type: .access)
            return [
                "Content-Type" : "application/json",
                "Authorization" : "Bearer \(accessToken ?? "")"
            ]
        }
        //return ["Content-Type": "application/json"]
    }
}
