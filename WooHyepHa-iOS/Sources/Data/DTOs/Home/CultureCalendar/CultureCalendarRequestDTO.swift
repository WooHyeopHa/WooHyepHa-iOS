//
//  CultureCalendarRequestDTO.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/15/24.
//

import Foundation

public struct CultureCalendarRequestDTO: Codable {
    let date: String
    let genre: [String]
    let sort: String
    
    enum CodingKeys: CodingKey {
        case date
        case genre
        case sort
    }
    
    public init(date: String, genre: [String], sort: String ) {
        self.date = date
        self.genre = genre
        self.sort = sort
    }
}
