//
//  NowHomeResponseDTO.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/11/24.
//

public struct NowHomeResponsesDTO: Codable {
    let status: String
    let message: String
    let data: NowHomeDataDTO
    
    enum CodingKeys: CodingKey {
        case status
        case message
        case data
    }
    
    public init(status: String, message: String, data: NowHomeDataDTO) {
        self.status = status
        self.message = message
        self.data = data
    }
}

extension NowHomeResponsesDTO {
    func toEntity() -> NowHome {
        NowHome(
            status: status,
            data: data.toEntity(),
            message: message
        )
    }
}

extension NowHomeResponsesDTO {
    static var testData = NowHomeResponsesDTO(
        status: "OK",
        message: "요청이 성공적으로 처리되었습니다.",
        data: NowHomeDataDTO(
            artRandomList: [
                ArtRandomListDTO(genre: "뮤지컬/연극", artId: 1, poster: "maniac"),
                ArtRandomListDTO(genre: "뮤지컬/연극", artId: 2, poster: "maniac"),
                ArtRandomListDTO(genre: "뮤지컬/연극", artId: 3, poster: "maniac"),
                ArtRandomListDTO(genre: "뮤지컬/연극", artId: 4, poster: "maniac"),
                ArtRandomListDTO(genre: "뮤지컬/연극", artId: 5, poster: "maniac"),
                ArtRandomListDTO(genre: "전시회", artId: 6, poster: "onstep"),
                ArtRandomListDTO(genre: "전시회", artId: 7, poster: "onstep"),
                ArtRandomListDTO(genre: "전시회", artId: 8, poster: "onstep"),
                ArtRandomListDTO(genre: "전시회", artId: 9, poster: "onstep"),
                ArtRandomListDTO(genre: "전시회", artId: 10, poster: "onstep"),
                ArtRandomListDTO(genre: "클래식/무용", artId: 11, poster: "sun"),
                ArtRandomListDTO(genre: "클래식/무용", artId: 12, poster: "sun"),
                ArtRandomListDTO(genre: "클래식/무용", artId: 13, poster: "sun"),
                ArtRandomListDTO(genre: "클래식/무용", artId: 14, poster: "sun"),
                ArtRandomListDTO(genre: "클래식/무용", artId: 15, poster: "sun"),
                ArtRandomListDTO(genre: "콘서트", artId: 15, poster: "hip"),
                ArtRandomListDTO(genre: "콘서트", artId: 15, poster: "hip"),
                ArtRandomListDTO(genre: "콘서트", artId: 15, poster: "hip"),
                ArtRandomListDTO(genre: "콘서트", artId: 15, poster: "hip"),
                ArtRandomListDTO(genre: "콘서트", artId: 15, poster: "hip")
            ],
            artTodayRandom: ArtTodayRandomDTO(title: "테스트테스트테스트테스트테스트테스트테스트", startDate: "2024.10.02", endDate: "2024.10.13")
        )
    )
}
