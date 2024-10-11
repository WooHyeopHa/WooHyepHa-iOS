//
//  NowHomeDataDTO.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/11/24.
//

import Foundation

public struct NowHomeDataDTO: Codable {
    let artRandomList: [ArtRandomListDTO]
    let artTodayRandom: ArtTodayRandomDTO
}

extension NowHomeDataDTO {
    func toEntity() -> NowHomeData {
        NowHomeData(
            artRandomList: artRandomList.map { $0.toEntity() },
            artTodayRandom: artTodayRandom.toEntity()
        )
    }
}
