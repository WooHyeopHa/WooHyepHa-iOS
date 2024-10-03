//
//  HomeHeaderView.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/3/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

class HomeHeaderView: BaseHeaderView {
    
    private let logoLabel = UILabel().then {
        $0.text = "findmuse"
        $0.textColor = .white
        $0.font = .poppinsSemiBold
        $0.textAlignment = .left
    }
    
    private let searchButton = UIButton().then {
        $0.setImage(.navSearch, for: .normal)
    }    
    
    private let alarmButton = UIButton().then {
        $0.setImage(.navBell, for: .normal)
    }
    
    private let buttonStackView =  UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillProportionally
        $0.spacing = 16
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setHeaderView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: SetUp HeaderView
    override func setHeaderView() {
        backgroundColor = .clear
        
        [searchButton, alarmButton].forEach {
            buttonStackView.addArrangedSubview($0)
        }
        
        [logoLabel, buttonStackView].forEach {
            addSubview($0)
        }
        showBottomBorder = false
    }
    
    override func setConstraints() {
        logoLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(64)
        }
        
        [searchButton, alarmButton].forEach {
            $0.snp.makeConstraints {
                $0.width.height.equalTo(24)
            }
        }
    }
}
