//
//  Map.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/23/24.
//

import Foundation

public struct ArtMap {
    let status: String
    let data: ArtMapData
    let message: String
}

public struct ArtMapData {
    let artMapList: [ArtMapList]
}
