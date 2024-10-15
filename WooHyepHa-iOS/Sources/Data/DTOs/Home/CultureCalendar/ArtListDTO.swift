//
//  ArtListDTO.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/15/24.
//

import Foundation

public struct ArtListDTO: Codable {
    let title: String
    let place: String
    let genre: String
    let poster: String
    let startDate: String
    let endDate: String
    let liked: Bool
    
    enum CodingKeys: CodingKey {
        case title
        case place
        case genre
        case poster
        case startDate
        case endDate
        case liked
    }
    
    public init(title: String, place: String, genre: String ,poster: String, startDate: String, endDate: String, liked: Bool) {
        self.title = title
        self.place = place
        self.genre = genre
        self.poster = poster
        self.startDate = startDate
        self.endDate = endDate
        self.liked = liked
    }
}

extension ArtListDTO {
    func toEntity() -> ArtList {
        ArtList(title: title, 
                place: place,
                genre: genre,
                poster: poster,
                startDate: startDate,
                endDate: endDate,
                liked: liked)
    }
}
