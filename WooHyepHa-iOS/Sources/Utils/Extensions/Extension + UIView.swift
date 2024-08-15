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
}
