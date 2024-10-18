//
//  AlarmButtonView.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/18/24.
//

import UIKit
import RxSwift
import RxCocoa
import Then
import SnapKit

class AlarmButtonView: BaseView {
    
    private var selectedButton: BottomBorderButton?
    
    private let activityButton = BottomBorderButton(title: "활동",  updateAppearanceTextColor: .MainColor).then {
        $0.updateAppearanceBottomBorderColor = UIColor.MainColor.cgColor
    }
    
    private let scheduleButton = BottomBorderButton(title: "일정",  updateAppearanceTextColor: .MainColor).then {
        $0.updateAppearanceBottomBorderColor = UIColor.MainColor.cgColor
    }
    
    private let bottomBorder = UIView().then {
        $0.backgroundColor = .gray8
    }
    
    private let buttonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
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
        [activityButton, scheduleButton].forEach {
            buttonStackView.addArrangedSubview($0)
        }
        
        [buttonStackView, bottomBorder].forEach {
            addSubview($0)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalToSuperview()
        }
        
        bottomBorder.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    override func bind() {
        inputAlarmButton
            .subscribe(with: self, onNext: { owner, type in
                owner.selectButton(type)
            })
            .disposed(by: disposeBag)
    }
    
    private func setInitialState() {
        activityButton.isSelected = true
        selectedButton = activityButton
    }
}

extension AlarmButtonView {
    enum alarmButtonType: String {
        case activity = "activity"
        case schedule = "schedule"
    }
    
    var inputAlarmButton: Observable<String> {
        return Observable.merge(
            activityButton.rx.tap.map { alarmButtonType.activity.rawValue },
            scheduleButton.rx.tap.map { alarmButtonType.schedule.rawValue }
        )
    }
}

private extension AlarmButtonView {
    func selectButton(_ field: String) {
        if let buttonType = alarmButtonType(rawValue: field) {
            let button: BottomBorderButton
            switch buttonType {
            case .activity:
                button = activityButton
            case .schedule:
                button = scheduleButton
            }
            
            if button != selectedButton {
                selectedButton?.isSelected = false
                button.isSelected = true
                selectedButton = button
            }
        }
    }
}

extension AlarmButtonView {
    var inputActivityButton: Observable<Void> {
        activityButton.rx.tap
            .asObservable()
    }    
    
    var inputScheduleButton: Observable<Void> {
        scheduleButton.rx.tap
            .asObservable()
    }
}
