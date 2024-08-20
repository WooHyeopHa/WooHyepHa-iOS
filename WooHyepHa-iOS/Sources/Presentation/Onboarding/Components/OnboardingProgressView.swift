//
//  OnboardingProgressView.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/20/24.
//

import UIKit

import SnapKit
import Then

class OnboardingProgressView: UIProgressView {

    private var progressValue: Float
    
    // MARK: init
    init(progressValue: Float) {
        self.progressValue = progressValue
        super.init(frame: .zero)
        setProgressView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension OnboardingProgressView {
    func setProgressView() {
        trackTintColor = .gray8
        progressTintColor = .MainColor
        clipsToBounds = true
        layer.cornerRadius = 3
        subviews[1].clipsToBounds = true
        layer.sublayers![1].cornerRadius = 3
        progress = progressValue
    }
}
