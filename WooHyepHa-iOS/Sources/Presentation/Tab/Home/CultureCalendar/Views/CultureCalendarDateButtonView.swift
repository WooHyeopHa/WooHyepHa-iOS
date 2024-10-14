//
//  CultureCalendarDateButtonView.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/14/24.
//

import UIKit
import RxSwift
import RxCocoa
import Then
import SnapKit

class CultureCalendarDateButtonView: BaseView {
    
    private var selectedButton: BottomBorderButton?
    
    private let todayButton = BottomBorderButton(title: "오늘")
    private let tomorrowButton = BottomBorderButton(title: "내일")
    private let weekButton = BottomBorderButton(title: "+1주")
    private let twoweeksButton = BottomBorderButton(title: "+2주")
    private let specifyDateButton = BottomBorderButton(title: "날짜지정")
    
    private let bottomBorder = UIView().then {
        $0.backgroundColor = .gray8
    }
    
    private let buttonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.distribution = .fillProportionally
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setInitialState()
        showTopBorder = false
        showBottomBorder = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setView() {
        backgroundColor = .white
        [todayButton, tomorrowButton, weekButton, twoweeksButton, specifyDateButton].forEach {
            buttonStackView.addArrangedSubview($0)
        }
        
        [buttonStackView, bottomBorder].forEach {
            addSubview($0)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalToSuperview()
        }
        
        bottomBorder.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
        
    }
    
    override func bind() {
        inputScrollButton
            .subscribe(with: self, onNext: { owner, type in
                owner.selectButton(type)
            })
            .disposed(by: disposeBag)
    }
    
    private func setInitialState() {
        todayButton.isSelected = true
        selectedButton = todayButton
    }
}

extension CultureCalendarDateButtonView {
    enum dateButtonType: String {
        case today = "today"
        case tomorrow = "tomorrow"
        case week = "week"
        case twoweeks = "twoweeks"
        case specifyDate = "specifyDate"
    }
    
    var inputScrollButton: Observable<String> {
        return Observable.merge(
            todayButton.rx.tap.map { dateButtonType.today.rawValue },
            tomorrowButton.rx.tap.map { dateButtonType.tomorrow.rawValue },
            weekButton.rx.tap.map { dateButtonType.week.rawValue },
            twoweeksButton.rx.tap.map { dateButtonType.twoweeks.rawValue },
            specifyDateButton.rx.tap.map { dateButtonType.specifyDate.rawValue }
        )
    }
}

private extension CultureCalendarDateButtonView {
    func selectButton(_ field: String) {
        if let buttonType = dateButtonType(rawValue: field) {
            let button: BottomBorderButton
            switch buttonType {
            case .today:
                button = todayButton
            case .tomorrow:
                button = tomorrowButton
            case .week:
                button = weekButton
            case .twoweeks:
                button = twoweeksButton
            case .specifyDate:
                button = specifyDateButton
            }
            
            if button != selectedButton {
                selectedButton?.isSelected = false
                button.isSelected = true
                selectedButton = button
            }
        }
    }
}
