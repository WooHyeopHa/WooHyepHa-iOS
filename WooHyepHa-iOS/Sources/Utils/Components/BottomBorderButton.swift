//
//  OnboardingScrollButton.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 9/30/24.
//

import UIKit

class BottomBorderButton: UIButton {
    
    private var title: String
    private let bottomBorder = CALayer()
    
    override var isSelected: Bool {
        didSet {
            updateAppearance()
        }
    }
    
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        setButton()
        setupBottomBorder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateBottomBorderFrame()
    }
}

private extension BottomBorderButton {
    func setButton() {
        setTitle(title, for: .normal)
        setTitleColor(.gray4, for: .normal)
        titleLabel?.font = .num2
        titleLabel?.textAlignment = .center
        updateAppearance()
        contentEdgeInsets = UIEdgeInsets(top: 7, left: 5, bottom: 7, right: 5)
    }
    
    func setupBottomBorder() {
        bottomBorder.backgroundColor = UIColor.gray2.cgColor
        bottomBorder.frame = CGRect(x: 0, y: self.frame.size.height - 3, width: self.frame.size.width, height: 3)
        bottomBorder.isHidden = true
        layer.addSublayer(bottomBorder)
    }
    
    func updateBottomBorderFrame() {
        bottomBorder.frame = CGRect(x: 0, y: self.frame.size.height - 3, width: self.frame.size.width, height: 3)
    }

    func updateAppearance() {
        if isSelected {
            setTitleColor(.gray2, for: .normal)
            bottomBorder.isHidden = false
        } else {
            setTitleColor(.gray4, for: .normal)
            bottomBorder.isHidden = true
        }
    }
}
