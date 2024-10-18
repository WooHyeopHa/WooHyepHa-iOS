//
//  CultureMarker.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/18/24.
//

import UIKit

import NMapsMap

final class CultureMarker: NMFMarker {
    override init() {
        super.init()
        setMarker()
    }
}

private extension CultureMarker {
    func setMarker() {
        let image = NMFOverlayImage(image: .mapMarker)
        self.iconImage = image
        self.width = CGFloat(NMF_MARKER_SIZE_AUTO)
        self.height = CGFloat(NMF_MARKER_SIZE_AUTO)
        
        self.iconPerspectiveEnabled = true
        
        self.anchor = CGPoint(x: 0.5, y: 0.5)
    }
}
