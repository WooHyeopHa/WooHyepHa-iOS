//
//  RegisterNicknameResponsesDTO.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/1/24.
//

public struct RegisterNicknameResponsesDTO: Codable {
    let status: String
    let message: String
    let data: AuthData
    
    public struct AuthData: Codable {
        let isDuplicated: Bool
        
        public init(isDuplicated: Bool) {
            self.isDuplicated = isDuplicated
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case status
        case message
        case data
    }
    
    public init(status: String, message: String, data: AuthData) {
        self.status = status
        self.message = message
        self.data = data
    }
}

extension RegisterNicknameResponsesDTO {
    func toEntity() -> Auth {
        Auth(isDuplicated: data.isDuplicated)
    }
}
