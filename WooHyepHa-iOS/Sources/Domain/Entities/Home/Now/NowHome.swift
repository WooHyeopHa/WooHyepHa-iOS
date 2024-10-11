//
//  NowHome.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/11/24.
//

import Foundation

public struct NowHome {
    let status: String
    let data: NowHomeData
    let message: String
}

public struct NowHomeData {
    let artRandomList: [ArtRandomList]
    let artTodayRandom: ArtTodayRandom
}
