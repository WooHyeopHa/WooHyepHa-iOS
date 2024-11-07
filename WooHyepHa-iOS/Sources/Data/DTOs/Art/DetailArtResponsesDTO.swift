//
//  DetailArtResponsesDTO.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 11/7/24.
//

import Foundation

public struct DetailArtResponsesDTO: Codable {
    let status: String
    let message: String
    let data: DetailArtDataDTO
    
    enum CodingKeys: CodingKey {
        case status
        case message
        case data
    }
    
    public init(status: String, message: String, data: DetailArtDataDTO) {
        self.status = status
        self.message = message
        self.data = data
    }
}

extension DetailArtResponsesDTO {
    func toEntity() -> DetailArt {
        DetailArt(status: status, data: data.toEntity(), message: message)
    }
}
