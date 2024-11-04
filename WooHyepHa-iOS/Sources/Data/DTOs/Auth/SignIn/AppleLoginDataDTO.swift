//
//  AppleLoginDTO.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 11/4/24.
//

import Foundation

public struct AppleLoginDataDTO: Codable {
    let id: Int
    let accountId: String
    let email: String?           // null 가능
    let nickname: String?        // null 가능
    let birthYear: Int
    let profileImageUrl: String? // null 가능
    let gender: String?         // null 가능
    let location: String?        // null 가능
    let comment: String?         // null 가능
    let artCount: Int
    let findMuseCount: Int
    let showStatus: Bool
    let alarmStatus: Bool
    let activateStatus: Bool
    let loginType: String?    // null 가능
    let refreshToken: String
}

extension AppleLoginDataDTO {
    func toEntity() -> AppleLoginData {
        AppleLoginData(
            id: id,
            accountId: accountId,
            email: email ?? "",
            nickname: nickname ?? "",
            birthYear: birthYear,
            profileImageUrl: profileImageUrl ?? "",
            gender: gender ?? "",
            location: location ?? "",
            comment: comment ?? "",
            artCount: artCount,
            findMuseCount: findMuseCount,
            showStatus: showStatus,
            alarmStatus: alarmStatus,
            activateStatus: activateStatus,
            loginType: loginType ?? "",
            refreshToken: refreshToken
        )
    }
}
