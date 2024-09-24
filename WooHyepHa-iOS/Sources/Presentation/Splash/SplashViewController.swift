//
//  SplashViewController.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/14/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

class SplashViewController: BaseViewController {

    //MARK: UI Components
    private let logoImageView = UIImageView().then {
        $0.image = .woohyephaBrandingLogo
    }
    
    private let subLogoLabel = UILabel().then {
        $0.text = "내 주변의 문화예술"
        $0.font = .body2
        $0.textColor = .white
        $0.alpha = 0
        $0.fadeIn(duration: 0.7)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setViewController() {
        view.backgroundColor = .MainColor
        
        [logoImageView, subLogoLabel].forEach {
            view.addSubview($0)
        }
    }
    
    override func setConstraints() {
        logoImageView.snp.makeConstraints {
            $0.centerX.centerY.equalTo(view.safeAreaLayoutGuide)
        }
        
        subLogoLabel.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(logoImageView.snp.bottom).inset(3)
        }
    }
}
