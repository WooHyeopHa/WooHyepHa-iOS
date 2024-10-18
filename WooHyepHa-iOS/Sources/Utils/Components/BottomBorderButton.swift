//
//  OnboardingScrollButton.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 9/30/24.
//

import UIKit

class BottomBorderButton: UIButton {
    
    private var title: String
    private var updateAppearanceTextColor: UIColor
    
    private let bottomBorder = CALayer()
    
    var fullBottomMode: Bool = false {
        didSet {
            
        }
    }
    
    var updateAppearanceBottomBorderColor: CGColor = UIColor.gray2.cgColor {
        didSet {
            bottomBorder.backgroundColor = updateAppearanceBottomBorderColor
        }
    }
    
    var titleColor: UIColor = .gray4 {
        didSet {
            setTitleColor(titleColor, for: .normal)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            updateAppearance()
        }
    }
    
    init(title: String, updateAppearanceTextColor: UIColor) {
        self.title = title
        self.updateAppearanceTextColor = updateAppearanceTextColor
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
            setTitleColor(updateAppearanceTextColor, for: .normal)
            bottomBorder.isHidden = false
        } else {
            setTitleColor(.gray4, for: .normal)
            bottomBorder.isHidden = true
        }
    }
}
