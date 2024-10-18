//
//  HomeButton.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/3/24.
//

import UIKit

class HomeButton: UIButton {
    
    private var title: String
    
    override var isSelected: Bool {
        didSet {
            updateAppearance()
        }
    }
    
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        setButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension HomeButton {
    func setButton() {
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.withAlphaComponent(0.4).cgColor
        setTitle(title, for: .normal)
        setTitleColor(.gray8, for: .normal)
        titleLabel?.font = .body6
        backgroundColor = .clear
        updateAppearance()
        
        contentEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    }

    func updateAppearance() {
        if isSelected {
            backgroundColor = .black.withAlphaComponent(0.3)
            layer.borderColor = UIColor.white.cgColor
            setTitleColor(.white, for: .normal)
        } else {
            backgroundColor = .clear
            layer.borderColor = UIColor.white.withAlphaComponent(0.4).cgColor
            setTitleColor(.gray8, for: .normal)
        }
    }
}
