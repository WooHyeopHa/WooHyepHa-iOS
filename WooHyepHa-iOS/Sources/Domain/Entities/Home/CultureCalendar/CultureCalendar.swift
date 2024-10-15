//
//  CultureCalendar.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/15/24.
//

import Foundation

public struct CultureCalendar {
    let status: String
    let data: CultureCalendarData
    let message: String
}

public struct CultureCalendarData {
    let artList: [ArtList]
}
