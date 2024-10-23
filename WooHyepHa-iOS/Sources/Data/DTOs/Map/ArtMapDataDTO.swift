//
//  ArtMapDataDTO.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/23/24.
//

import Foundation

public struct ArtMapDataDTO: Codable {
    let artMapList: [ArtMapListDTO]
}

extension ArtMapDataDTO {
    func toEntity() -> ArtMapData {
        ArtMapData(
            artMapList: artMapList.map { $0.toEntity() }
        )
    }
}
