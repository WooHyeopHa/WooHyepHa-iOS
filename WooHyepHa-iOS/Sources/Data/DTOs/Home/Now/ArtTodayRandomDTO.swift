//
//  ArtTodayRandomDTO.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/11/24.
//

import Foundation

public struct ArtTodayRandomDTO: Codable {
    let title: String
    let startDate: String
    let endDate: String
    
    enum CodingKeys: CodingKey {
        case title
        case startDate
        case endDate
    }
    
    public init(title: String, startDate: String, endDate: String) {
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
    }
}

extension ArtTodayRandomDTO {
    func toEntity() -> ArtTodayRandom {
        ArtTodayRandom(
            title: title,
            startDate: startDate,
            endDate: endDate
        )
    }
}
