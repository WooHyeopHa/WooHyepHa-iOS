//
//  Extension + UIFont.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 7/31/24.
//

import UIKit

extension UIFont {
    enum Pretendard: String {
        case pretendardBold = "Pretendard-Bold"
        case pretendardSemiBold = "Pretendard-SemiBold"
        case pretendardMedium = "Pretendard-Medium"
        case pretendardRegular = "Pretendard-Regular"
        case pretendradLight = "Pretendard-Light"
    }
    
    enum Poppins: String {
        case poppinsMedium = "Poppins-Medium"
        case poppinsSemiBold = "Poppins-SemiBold"
    }
}

extension UIFont {
    static let h1 = UIFont(name: Pretendard.pretendardBold.rawValue, size: 28)!
    static let h2 = UIFont(name: Pretendard.pretendardBold.rawValue, size: 24)!
    static let h3 = UIFont(name: Pretendard.pretendardBold.rawValue, size: 22)!

    static let sub1 = UIFont(name: Pretendard.pretendardBold.rawValue, size: 20)!
    static let sub2 = UIFont(name: Pretendard.pretendardBold.rawValue, size: 18)!
    static let sub3 = UIFont(name: Pretendard.pretendardMedium.rawValue, size: 18)!
    static let sub4 = UIFont(name: Pretendard.pretendardSemiBold.rawValue, size: 18)!
    static let sub5 = UIFont(name: Pretendard.pretendardSemiBold.rawValue, size: 15)!
    
    static let caption1 = UIFont(name: Pretendard.pretendardBold.rawValue, size: 12)!
    static let caption2 = UIFont(name: Pretendard.pretendardRegular.rawValue, size: 12)!
    static let caption3 = UIFont(name: Pretendard.pretendardSemiBold.rawValue, size: 11)!
    static let caption4 = UIFont(name: Pretendard.pretendardRegular.rawValue, size: 13)!
    static let caption5 = UIFont(name: Pretendard.pretendardSemiBold.rawValue, size: 12)!
    static let caption6 = UIFont(name: Pretendard.pretendardMedium.rawValue, size: 13)!
    static let caption7 = UIFont(name: Pretendard.pretendardRegular.rawValue, size: 11)!
    
    static let body1 = UIFont(name: Pretendard.pretendardBold.rawValue, size: 16)!
    static let body2 = UIFont(name: Pretendard.pretendardMedium.rawValue, size: 16)!
    static let body3 = UIFont(name: Pretendard.pretendardBold.rawValue, size: 14)!
    static let body4 = UIFont(name: Pretendard.pretendardMedium.rawValue, size: 14)!
    static let body5 = UIFont(name: Pretendard.pretendardSemiBold.rawValue, size: 14)!
    static let body6 = UIFont(name: Pretendard.pretendardRegular.rawValue, size: 14)!
    static let body7 = UIFont(name: Pretendard.pretendardMedium.rawValue, size: 15)!
    static let body8 = UIFont(name: Pretendard.pretendardRegular.rawValue, size: 15)!
    static let body9 = UIFont(name: Pretendard.pretendardRegular.rawValue, size: 16)!
    static let body10 = UIFont(name: Pretendard.pretendardBold.rawValue, size: 26)!
       
    static let num1 = UIFont(name: Pretendard.pretendardSemiBold.rawValue, size: 16)!
    static let num2 = UIFont(name: Pretendard.pretendardSemiBold.rawValue, size: 14)!
    static let num3 = UIFont(name: Pretendard.pretendardSemiBold.rawValue, size: 8)!
    
    static let poppinsMedium = UIFont(name: Poppins.poppinsMedium.rawValue, size: 50)!
    static let poppinsSemiBold = UIFont(name: Poppins.poppinsSemiBold.rawValue, size: 18)!
}
