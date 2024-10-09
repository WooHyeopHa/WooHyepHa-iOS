//
//  CultureCalendarHeaderView.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/9/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

class CultureCalendarHeaderView: BaseHeaderView {
    
    private let nowButton = UIButton().then {
        let attributedString = NSMutableAttributedString(string: "Now")
        attributedString.addAttribute(NSAttributedString.Key.kern, value: CGFloat(-0.89), range: NSRange(location: 0, length: attributedString.length - 1))
        
        $0.setAttributedTitle(attributedString, for: .normal)
        $0.titleLabel?.font = .poppinsSemiBold
        $0.titleLabel?.textAlignment = .left
        $0.setTitleColor(.gray6, for: .normal)
    }
    
    private let calendarButton = UIButton().then {
        let attributedString = NSMutableAttributedString(string: "Calendar")
        attributedString.addAttribute(NSAttributedString.Key.kern, value: CGFloat(-0.89), range: NSRange(location: 0, length: attributedString.length - 1))
        
        $0.setAttributedTitle(attributedString, for: .normal)
        $0.titleLabel?.font = .poppinsSemiBold
        $0.titleLabel?.textAlignment = .left
        $0.setTitleColor(.gray1, for: .normal)
    }
    
    private let searchButton = UIButton().then {
        $0.setImage(.navSearch.withTintColor(.black), for: .normal)
    }
    
    private let alarmButton = UIButton().then {
        $0.setImage(.navBell.withTintColor(.black), for: .normal)
    }
    
    private let leftButtonStackView =  UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillProportionally
        $0.spacing = 20
    }
    
    private let rightButtonStackView =  UIStackView().then {
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
        
        [nowButton, calendarButton].forEach {
            leftButtonStackView.addArrangedSubview($0)
        }
        
        [searchButton, alarmButton].forEach {
            rightButtonStackView.addArrangedSubview($0)
        }
        
        [leftButtonStackView, rightButtonStackView].forEach {
            addSubview($0)
        }
        
        showBottomBorder = false
    }
    
    override func setConstraints() {
        leftButtonStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalTo(140)
        }
        
        rightButtonStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(64)
        }
        
        [nowButton, calendarButton].forEach {
            $0.snp.makeConstraints {
                $0.height.equalTo(36)
            }
        }
        
        [searchButton, alarmButton].forEach {
            $0.snp.makeConstraints {
                $0.width.height.equalTo(24)
            }
        }
    }
}

extension CultureCalendarHeaderView {
    var inputNowButton: Observable<Void> {
        nowButton.rx.tap
            .asObservable()
    }
    
    var inputCalendarButton: Observable<Void> {
        calendarButton.rx.tap
            .asObservable()
    }
    
    var inputSearchButton: Observable<Void> {
        searchButton.rx.tap
            .asObservable()
    }
    
    var inputAlarmButton: Observable<Void> {
        alarmButton.rx.tap
            .asObservable()
    }
}
