//
//  HomeService.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/11/24.
//

import Moya

public enum HomeService {
    case fetchNowHome(userId: Int)
    case fetchCultureCalendar(userId: Int, request: CultureCalendarRequestDTO)
}

extension HomeService: TargetType {
    public var baseURL: URL {
        return URL(string: "https://findmuse.store")!
    }
    
    public var path: String {
        switch self {
        case .fetchNowHome(let userId):
            return "/art/home/\(userId)"
        case .fetchCultureCalendar(let userId, _):
            return "/art/list/condition/\(userId)"
        }
    }
    
    public var method: Method {
        switch self {
        case .fetchNowHome, .fetchCultureCalendar:
            return .get
        }
    }
    
    public var task: Task {
        switch self {
        case .fetchNowHome:
            return .requestPlain
        case .fetchCultureCalendar(_, let request):
            return .requestParameters(
                parameters: [
                    "date": request.date,
                    "genre": request.genre,
                    "sort": request.sort
                ],
                encoding: URLEncoding.queryString
            )
        }
    }
    
    public var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
