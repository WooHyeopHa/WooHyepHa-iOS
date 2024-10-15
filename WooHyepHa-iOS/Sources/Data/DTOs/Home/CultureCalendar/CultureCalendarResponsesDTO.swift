//
//  CultureCalendarResponsesDTO.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/15/24.
//

import Foundation

public struct CultureCalendarResponsesDTO: Codable {
    let status: String
    let data: CultureCalendarDataDTO
    let message: String

    enum CodingKeys: CodingKey {
        case status
        case data
        case message
    }
    
    public init(status: String, data: CultureCalendarDataDTO, message: String) {
        self.status = status
        self.data = data
        self.message = message
    }
}

extension CultureCalendarResponsesDTO {
    func toEntity() -> CultureCalendar {
        CultureCalendar(
            status: status, 
            data: data.toEntity(),
            message: message
        )
    }
}

extension CultureCalendarResponsesDTO {
    static var testData = CultureCalendarResponsesDTO(
        status: "OK",
        data: CultureCalendarDataDTO(
            artList:  [
                ArtListDTO(title: "[썸머위크] 이경준 사진전: 스텝 어웨이", place: "그라운드 시소 센트럴", genre: "뮤지컬/연극", poster: "maniac", startDate: "2024.07.09", endDate: "08.25", liked: true),
                ArtListDTO(title: "2024 연극 <킬롤로지> : 연극열전10_ 세 번째 작품", place: "그라운드 시소 센트럴", genre: "뮤지컬/연극", poster: "sun", startDate: "2024.07.09", endDate: "08.25", liked: false),
                ArtListDTO(title: "2024 연극 <킬롤로지> : 연극열전10_ 세 번째 작품", place: "그라운드 시소 센트럴", genre: "전시회", poster: "onstep", startDate: "2024.07.09", endDate: "08.25", liked: false),
                ArtListDTO(title: "2024 연극 <킬롤로지> : 연극열전10_ 세 번째 작품", place: "그라운드 시소 센트럴", genre: "콘서트", poster: "onestep", startDate: "2024.07.09", endDate: "08.25", liked: false),
                ArtListDTO(title: "2024 연극 <킬롤로지> : 연극열전10_ 세 번째 작품", place: "그라운드 시소 센트럴", genre: "클래식/무용", poster: "hip", startDate: "2024.07.09", endDate: "08.25", liked: false),
            ]
        ),
        message: "요청이 성공적으로 이루어졌습니다."
    )
}
