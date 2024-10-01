//
//  RegisterNicknameRequestDTO.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/1/24.
//

public struct RegisterNicknameRequestDTO: Codable {
    let nickName: String?
    
    enum CodingKeys: CodingKey {
        case nickName
    }
    
    public init(nickName: String) {
        self.nickName = nickName
    }
}

