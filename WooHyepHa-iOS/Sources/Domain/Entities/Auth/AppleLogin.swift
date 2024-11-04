//
//  AppleLogin.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 11/4/24.
//

import Foundation

public struct AppleLogin {
    let status: String
    let data: AppleLoginData
    let message: String
}

public struct AppleLoginData {
    let id: Int
    let accountId: String
    let email: String
    let nickname: String
    let birthYear: Int
    let profileImageUrl: String
    let gender: String
    let location: String
    let comment: String
    let artCount: Int
    let findMuseCount: Int
    let showStatus: Bool
    let alarmStatus: Bool
    let activateStatus: Bool
    let loginType: String
    let refreshToken: String
}
