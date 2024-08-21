//
//  SelectPurposeView.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/21/24.
//

import UIKit

import Then
import SnapKit
import RxCocoa
import RxSwift

class SelectPurposeView: BaseView {
    private var currentlySelectedButton: OnboardingButton?
    
    private let learnButton = OnboardingButton(title: "지식습득")
    private let healingButton = OnboardingButton(title: "휴식 및 힐링")
    private let socialActivitiesButton = OnboardingButton(title: "사회적 활동")
    private let inspirationButton = OnboardingButton(title: "영감 및 창의성")
    private let etcButton = OnboardingButton(title: "기타")
    
    private let verticalStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 18
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setView() {
        showTopBorder = false
        showBottomBorder = false
        
        [learnButton, healingButton, socialActivitiesButton, inspirationButton, etcButton].forEach {
            verticalStackView.addArrangedSubview($0)
        }
        
        addSubview(verticalStackView)
    }
    
    override func setConstraints() {
        verticalStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalToSuperview()
        }
        
        [learnButton, healingButton, socialActivitiesButton, inspirationButton, etcButton].forEach {
            $0.snp.makeConstraints {
                $0.height.equalTo(48)
            }
        }
    }
    
    override func bind() {
        inputSelectPurpose
            .subscribe(with: self, onNext: { owner, type in
                owner.toggleButton(type)
            })
            .disposed(by: disposeBag)
    }
}

extension SelectPurposeView {
    enum SelectPurposeButtonType: String {
        case learn = "learn"
        case healing = "healing"
        case socialActivities = "socialActivities"
        case inspiration = "inspiration"
        case etc = "etc"
    }
    
    var inputSelectPurpose: Observable<String> {
        return Observable.merge(
            learnButton.rx.tap.map { SelectPurposeButtonType.learn.rawValue },
            healingButton.rx.tap.map { SelectPurposeButtonType.healing.rawValue },
            socialActivitiesButton.rx.tap.map { SelectPurposeButtonType.socialActivities.rawValue },
            inspirationButton.rx.tap.map { SelectPurposeButtonType.inspiration.rawValue },
            etcButton.rx.tap.map { SelectPurposeButtonType.etc.rawValue }
        )
    }
}

extension SelectPurposeView {
    private func toggleButton(_ field: String) {
        if let buttonType = SelectPurposeButtonType(rawValue: field) {
            let button: OnboardingButton
            switch buttonType {
            case .learn:
                button = learnButton
            case .healing:
                button = healingButton
            case .socialActivities:
                button = socialActivitiesButton
            case .inspiration:
                button = inspirationButton
            case .etc:
                button = etcButton
            }
            
            if button != currentlySelectedButton {
                currentlySelectedButton?.isSelected = false
                button.isSelected = true
                currentlySelectedButton = button
            }
        }
    }
}
