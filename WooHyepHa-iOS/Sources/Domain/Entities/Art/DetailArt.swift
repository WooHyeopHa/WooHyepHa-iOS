//
//  DetailArt.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 11/7/24.
//

import Foundation

public struct DetailArt {
    let status: String
    let data: DetailArtData
    let message: String
}

public struct DetailArtData {
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
    let startScore: Double
    let reviewCnt: Int
    let spark: String
}
