//
//  Extension + UIImage.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/22/24.
//

import UIKit

extension UIImage {
    func resize(to size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage ?? self
    }
}
