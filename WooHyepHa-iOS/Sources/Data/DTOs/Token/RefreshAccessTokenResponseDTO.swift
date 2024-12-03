//
//  RefreshTokenResponseDTO.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 12/3/24.
//

import Foundation

struct RefreshAccessTokenResponseDTO: Decodable {
    let status: String
    let data: AccessTokenDTO
    let message: String
}

struct AccessTokenDTO: Decodable {
    let accessToken: String
}
