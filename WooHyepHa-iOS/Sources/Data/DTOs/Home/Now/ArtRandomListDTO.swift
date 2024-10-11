//
//  ArtRandomListDTO.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/11/24.
//

public struct ArtRandomListDTO: Codable {
    let genre: String
    let artId: Int
    let poster: String
    
    enum CodingKeys: CodingKey {
        case genre
        case artId
        case poster
    }
    
    public init(genre: String, artId: Int, poster: String) {
        self.genre = genre
        self.artId = artId
        self.poster = poster
    }
}

extension ArtRandomListDTO {
    func toEntity() -> ArtRandomList {
        ArtRandomList(
            genre: genre,
            artId: artId,
            poster: poster
        )
    }
}
