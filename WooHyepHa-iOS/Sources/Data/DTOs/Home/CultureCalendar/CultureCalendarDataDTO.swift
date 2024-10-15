//
//  CultureCalendarDataDTO.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/15/24.
//

import Foundation

public struct CultureCalendarDataDTO: Codable {
    let artList: [ArtListDTO]
}

extension CultureCalendarDataDTO {
    func toEntity() -> CultureCalendarData {
        CultureCalendarData(
            artList: artList.map { $0.toEntity() }
        )
    }
}
