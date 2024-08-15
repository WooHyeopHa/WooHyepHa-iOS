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
    private let logoLabel = UILabel().then {
        $0.text = "LOGO"
        $0.font = .systemFont(ofSize: 100)
        $0.textColor = .white
        $0.alpha = 0
        $0.fadeIn(duration: 0.5)
    } // 로고 나중에 에셋 파일 받으면 이미지로 수정
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setViewController() {
        view.backgroundColor = .MainColor
        
        [logoLabel].forEach {
            view.addSubview($0)
        }
    }
    
    override func setConstraints() {
        logoLabel.snp.makeConstraints {
            $0.centerX.centerY.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
