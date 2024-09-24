//
//  SignInWithAppleRequestDTO.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/26/24.
//

public struct SignInWithAppleRequestDTO: Codable {
    let code: String?
    let id_token: String?
    
    enum CodingKeys: CodingKey {
        case code
        case id_token
    }
    
    public init(code: String, id_token: String) {
        self.code = code
        self.id_token = id_token
    }
}

