//
//  DetailArtDataDTO.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 11/7/24.
//

import Foundation

public struct DetailArtDataDTO: Codable {
    let poster: String
    let title: String
    let genre: String
    let age: String
    let place: String
    let startDate: String
    let endDate: String
    let startTime: String
    let park: String
    let detailPhoto: String
    let startScore: Double?
    let reviewCnt: Int
    let spark: String
}

extension DetailArtDataDTO {
    func toEntity() -> DetailArtData {
        DetailArtData(
            poster: poster, title: title, genre: genre, age: age, place: place, startDate: startDate, endDate: endDate, startTime: startTime, park: park, detailPhoto: detailPhoto, startScore: startScore ?? 0.0, reviewCnt: reviewCnt, spark: spark
        )
    }
}
