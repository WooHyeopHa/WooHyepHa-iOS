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
            print("touch")
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
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray7.cgColor
        setTitle(title, for: .normal)
        setTitleColor(.gray3, for: .normal)
        titleLabel?.font = .body4
        updateAppearance()
    }

    func updateAppearance() {
        if isSelected {
            layer.borderColor = UIColor.MainColor.cgColor
            setTitleColor(.MainColor, for: .normal)
        } else {
            layer.borderColor = UIColor.gray7.cgColor
            setTitleColor(.gray3, for: .normal)
        }
    }
}
