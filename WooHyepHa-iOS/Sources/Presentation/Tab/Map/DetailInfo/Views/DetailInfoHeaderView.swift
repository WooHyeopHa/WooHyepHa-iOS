//
//  DetailInfoHeaderView.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 11/1/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

class DetailInfoHeaderView: BaseHeaderView {
    
    private let backButton = UIButton().then {
        $0.setImage(.chevronLeftarrow, for: .normal)
    }
    
    private let homeButton = UIButton().then {
        $0.setImage(.navHomeBlack, for: .normal)
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .num1
        $0.textColor = .gray1
        $0.textAlignment = .center
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: SetUp HeaderView
    override func setHeaderView() {
        backgroundColor = .clear
    
        [backButton, titleLabel, homeButton].forEach {
            addSubview($0)
        }
        
        showBottomBorder = false
    }
    
    override func setConstraints() {
        backButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.width.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(backButton.snp.trailing).offset(10)
            $0.trailing.equalTo(homeButton.snp.leading).offset(10)
        }
        
        homeButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
            $0.width.height.equalTo(24)
        }
    }
}

extension DetailInfoHeaderView {
    var inputBackButton: Observable<Void> {
        backButton.rx.tap
            .asObservable()
    }
    
    var inputHomeButton: Observable<Void> {
        homeButton.rx.tap
            .asObservable()
    }
}

