//
//  OnboardingButton.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/21/24.
//

import UIKit

class OnboardingButton: UIButton {
    
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

private extension OnboardingButton {
    func setButton() {
        layer.cornerRadius = 18
        layer.borderWidth = 0
        setTitle(title, for: .normal)
        setTitleColor(.gray, for: .normal)
        titleLabel?.font = .body4
        updateAppearance()
    }

    func updateAppearance() {
        if isSelected {
            backgroundColor = .MainColor.withAlphaComponent(0.1)
            layer.borderColor = UIColor.MainColor.cgColor
            layer.borderWidth = 1
            setTitleColor(.MainColor, for: .normal)
        } else {
            backgroundColor = .gray9
            layer.borderColor = UIColor.gray9.cgColor
            layer.borderWidth = 0
            setTitleColor(.gray1, for: .normal)
        }
    }
}
