//
//  SignInWithAppleResponsesDTO.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/26/24.
//

public struct SignInWithAppleResponsesDTO: Codable {
    let status: String
    let message: String
    let data: [String: String]?
    
    enum CodingKeys: CodingKey {
        case status
        case message
        case data
    }
    
    public init(status: String, message: String, data: [String: String]) {
        self.status = status
        self.message = message
        self.data = data
    }
}

