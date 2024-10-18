//
//  UserMarker.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/18/24.
//

import UIKit

import NMapsMap

final class UserMarker: NMFMarker {
    override init() {
        super.init()
        setMarker()
    }
}

private extension UserMarker {
    func createCircleImage(diameter: CGFloat, color: UIColor) -> UIImage {
        let size = CGSize(width: diameter, height: diameter)
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { ctx in
            ctx.cgContext.setFillColor(color.cgColor)
            ctx.cgContext.fillEllipse(in: CGRect(origin: .zero, size: size))
        }
    }
    
    func setMarker() {
        let image = NMFOverlayImage(image: UIImage(named: "userMarker")!)
        self.iconImage = image
        self.width = CGFloat(NMF_MARKER_SIZE_AUTO)
        self.height = CGFloat(NMF_MARKER_SIZE_AUTO)

        
        self.iconPerspectiveEnabled = true
        
        self.anchor = CGPoint(x: 0.5, y: 0.5)
    }
}
