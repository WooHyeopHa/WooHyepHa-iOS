//
//  Extension + UIColor.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 7/31/24.
//

import UIKit

extension UIColor {
  /// Hex Color를 변환시켜 UIColor 색상을 설정합니다.
  /// ```
  /// let homeColor: UIColor = UIColor(hex: 0xF4F100)
  /// ```
  /// - Parameters:
  ///   - hexCode: 16진수의 Unsigned Int 값
  ///   - alpha: 투명도 값으로 0 or 1로 가져와야 합니다.
  convenience init(hexCode: UInt, alpha: CGFloat = 1.0) {
    self.init(
      red: CGFloat((hexCode & 0xFF0000) >> 16) / 255.0,
      green: CGFloat((hexCode & 0x00FF00) >> 8) / 255.0,
      blue: CGFloat(hexCode & 0x0000FF) / 255.0,
      alpha: CGFloat(alpha)
    )
  }
}

extension UIColor {
    // Main Color
    static let MainColor = UIColor(hexCode: 0xFF4C01)
    
    // Sub Color
    static let SubColor = UIColor(hexCode: 0x4590FF)
    static let bgBlack = UIColor(hexCode: 0x0F0F0F)
    static let borderRed = UIColor(hexCode: 0xF32F36)
    
    // Grayscale
    static let gray1 = UIColor(hexCode: 0x212121)
    static let gray2 = UIColor(hexCode: 0x424242)
    static let gray3 = UIColor(hexCode: 0x616161)
    static let gray4 = UIColor(hexCode: 0x757575)
    static let gray5 = UIColor(hexCode: 0x9E9E9E)
    static let gray6 = UIColor(hexCode: 0xBDBDBD)
    static let gray7 = UIColor(hexCode: 0xE0E0E0)
    static let gray8 = UIColor(hexCode: 0xEEEEEE)
    static let gray9 = UIColor(hexCode: 0xF5F5F5)
}

