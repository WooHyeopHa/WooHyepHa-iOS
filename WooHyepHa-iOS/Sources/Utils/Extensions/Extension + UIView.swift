//
//  Extension + UIView.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/15/24.
//

import UIKit

extension UIView {
    func fadeIn(duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.alpha = 1.0
        }
    }
    
    func fadeOut(duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.alpha = 0.0
        }
    }
    
    /// 해당 View에 그림자를 생성합니다.
    /// ```
    /// view.addViewShadow()
    /// ```

    func addViewShadow(shadowRadius: CGFloat = 3.0, shadowOpacity: Float = 0.6) {
        layer.masksToBounds = false
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 3, height: 3)
    }
    
    /// 해당 View에 색상이 있는 그림자를 생성합니다.
    /// ```
    /// view.addViewColorShadow(color: .blue)
    /// ```
    ///  - Parameters:
    ///   - color: 그림자의 색상 (UIColor)
    func addViewColorShadow (color: UIColor){
        layer.shadowColor = color.cgColor
        layer.masksToBounds = false
        layer.shadowRadius = 15.0
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0, height: 4)
    }
}
