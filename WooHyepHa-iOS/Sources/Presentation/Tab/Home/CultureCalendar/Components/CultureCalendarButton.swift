//
//  CultureCalendarButton.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/14/24.
//

import UIKit

class CultureCalendarButton: UIButton {
    
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

private extension CultureCalendarButton {
    func setButton() {
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray7.cgColor
        setTitle(title, for: .normal)
        setTitleColor(.gray1, for: .normal)
        titleLabel?.font = .body6
        backgroundColor = .clear
        updateAppearance()
        
        contentEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    }

    func updateAppearance() {
        if isSelected {
            backgroundColor = .gray1
            layer.borderColor = UIColor.gray1.cgColor
            setTitleColor(.white, for: .normal)
        } else {
            backgroundColor = .clear
            layer.borderColor = UIColor.gray7.cgColor
            setTitleColor(.gray1, for: .normal)
        }
    }
}
