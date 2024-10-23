//
//  ArtMapDTO.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/23/24.
//

import Foundation

public struct ArtMapResponsesDTO: Codable {
    let status: String
    let message: String
    let data: ArtMapDataDTO
    
    enum CodingKeys: CodingKey {
        case status
        case message
        case data
    }
    
    public init(status: String, message: String, data: ArtMapDataDTO) {
        self.status = status
        self.message = message
        self.data = data
    }
}

extension ArtMapResponsesDTO {
    func toEntity() -> ArtMap {
        ArtMap(
            status: status,
            data: data.toEntity(),
            message: message
        )
    }
}

extension ArtMapResponsesDTO {
    static var testData = ArtMapResponsesDTO(
        status: "OK",
        message: "요청이 성공적으로 처리되었습니다.",
        data: ArtMapDataDTO(
            artMapList: [
                ArtMapListDTO(latitude: "37.5835167", longitude: "127.000494", poster: "hip", title: "두아 리파 내한 공연", artId: 1, genre: "콘서트", place: "세종문화회관 (세종M씨어터)", startDate: "2024.12.12", endDate: "2024.12.29"),
                ArtMapListDTO(latitude: "37.5846181", longitude: "126.9987679", poster: "hip", title: "멜론 어워드", artId: 2, genre: "콘서트", place: "세종문화회관 (세종M씨어터)", startDate: "2024.12.12", endDate: "2024.12.29"),
                ArtMapListDTO(latitude: "37.5868754", longitude: "126.9998622", poster: "munch", title: "투애니원 콘서트", artId: 3, genre: "콘서트", place: "세종문화회관 (세종M씨어터)", startDate: "2024.12.12", endDate: "2024.12.29"),
                ArtMapListDTO(latitude: "37.5815764", longitude: "127.0053164", poster: "munch", title: "배고파배고파배고파", artId: 4, genre: "뮤지컬/연극", place: "세종문화회관 (세종M씨어터)", startDate: "2024.12.12", endDate: "2024.12.29"),
                ArtMapListDTO(latitude: "37.576834", longitude: "127.0031357", poster: "munch", title: "두여자", artId: 5, genre: "뮤지컬/연극", place: "세종문화회관 (세종M씨어터)", startDate: "2024.12.12", endDate: "2024.12.29"),
                ArtMapListDTO(latitude: "37.5785997", longitude: "126.9862442", poster: "onstep", title: "스위치", artId: 6, genre: "뮤지컬/연극", place: "세종문화회관 (세종M씨어터)", startDate: "2024.12.12", endDate: "2024.12.29"),
                ArtMapListDTO(latitude: "37.5716188", longitude: "127.000782", poster: "onstep", title: "챔피언스 리그", artId: 7, genre: "클래식/무용", place: "세종문화회관 (세종M씨어터)", startDate: "2024.12.12", endDate: "2024.12.29"),
                ArtMapListDTO(latitude:  "37.5812726", longitude: "127.0015344", poster: "onstep", title: "코난 그레이 내한공연", artId: 8, genre: "뮤지컬/연극", place: "세종문화회관 (세종M씨어터)", startDate: "2024.12.12", endDate: "2024.12.29"),
                ArtMapListDTO(latitude: "37.5834327", longitude: "126.0021494", poster: "sun", title: "[슈퍼 얼리버드] 디즈니 100년 특별전", artId: 9, genre: "연극", place: "세종문화회관 (세종M씨어터)", startDate: "2024.12.12", endDate: "2024.12.29"),
        ])
    )
}
