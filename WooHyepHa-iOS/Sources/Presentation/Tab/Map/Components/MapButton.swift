//
//  MapButton.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/22/24.
//

import UIKit

class MapButton: UIButton {
    
    private var title: String
    private var image: UIImage
    
    override var isSelected: Bool {
        didSet {
            updateAppearance()
        }
    }
    
    init(title: String, image: UIImage) {
        self.title = title
        self.image = image
        super.init(frame: .zero)
        setButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MapButton {
    func setButton() {
        layer.cornerRadius = 18
        setTitle(title, for: .normal)
        setTitleColor(.gray1, for: .normal)
        titleLabel?.font = .body6
        backgroundColor = .white
        
        let resizedImage = image.resize(to: CGSize(width: 16, height: 16))
        setImage(resizedImage, for: .normal)
        
        imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 2)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: -2)
        
        semanticContentAttribute = .forceLeftToRight
        contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        
        addViewShadow(shadowRadius: 5.0, shadowOpacity: 0.1)
    }

    func updateAppearance() {
        if isSelected {
            layer.borderWidth = 1
            layer.borderColor = UIColor.gray1.cgColor
            titleLabel?.font = .body4
        } else {
            layer.borderWidth = 0
            titleLabel?.font = .body6
        }
    }
}
