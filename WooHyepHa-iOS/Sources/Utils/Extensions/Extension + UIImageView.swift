//
//  Extension + UIImageView.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/3/24.
//

import UIKit
import Kingfisher

extension UIImageView {
    func addBlurEffect(style: UIBlurEffect.Style = .light) {
        let blurEffect = UIBlurEffect(style: style)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = bounds
        blurredEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurredEffectView)
    }
    
    func setImageKingfisher(with urlString: String) {
        guard let url = URL.init(string: urlString) else {
            return
        }
        kf.indicatorType = .activity
        kf.setImage(with: url)
    }
}
