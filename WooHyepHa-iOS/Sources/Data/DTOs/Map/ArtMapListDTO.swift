//
//  ArtMapListDTO.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/23/24.
//

import Foundation

public struct ArtMapListDTO: Codable {
    let latitude: String
    let longitude: String
    let poster: String
    let title: String
    let artId: Int
    let genre: String
    let place: String
    let startDate: String
    let endDate: String
    
    enum CodingKeys: CodingKey {
        case latitude
        case longitude
        case poster
        case title
        case artId
        case genre
        case place
        case startDate
        case endDate
    }
    
    public init(latitude: String, longitude: String, poster: String, title: String, artId: Int, genre: String, place: String, startDate: String, endDate: String) {
        self.latitude = latitude
        self.longitude = longitude
        self.poster = poster
        self.title = title
        self.artId = artId
        self.genre = genre
        self.place = place
        self.startDate = startDate
        self.endDate = endDate
    }
}

extension ArtMapListDTO {
    func toEntity() -> ArtMapList {
        ArtMapList(
            latitude: latitude, longitude: longitude, poster: poster, title: title, artId: artId, genre: genre, place: place, startDate: startDate, endDate: endDate
        )
    }
}
