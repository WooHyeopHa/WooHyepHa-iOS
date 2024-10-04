//
//  GradientView.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/4/24.
//

import UIKit

class GradientView: UIView {
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    var gradientLayer: CAGradientLayer {
        return layer as! CAGradientLayer
    }
    
    func setupGradient(colors: [UIColor], locations: [NSNumber]? = nil) {
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.locations = locations
    }
}
