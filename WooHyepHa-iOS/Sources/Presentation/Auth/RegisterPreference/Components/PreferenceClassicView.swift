//
//  PreferenceClassicView.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/21/24.
//

import UIKit
import RxSwift
import RxCocoa
import Then
import SnapKit

class PreferenceClassicView: BaseView {
    
    private let orchestraButton = OnboardingButton(title: "오케스트라")
    private let operaButton = OnboardingButton(title: "오페라")
    private let balletButton = OnboardingButton(title: "발레")
    private let modernDanceButton = OnboardingButton(title: "현대무용")
    private let traditionalDanceButton = OnboardingButton(title: "전통무용")
    private let koreanTraditionalMusicButton = OnboardingButton(title: "국악")
    
    private let titleLabel = UILabel().then {
        $0.text = "어떤 장르의 클래식/무용을 선호하시나요?"
        $0.font = .body1
        $0.textColor = .gray2
    }
    
    private let buttonStackView1 = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.distribution = .fillProportionally
    }
    
    private let buttonStackView2 = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.distribution = .fillProportionally
    }
    
    private let verticalStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 12
        $0.distribution = .equalSpacing
        $0.alignment = .leading
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        showTopBorder = false
        showBottomBorder = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setView() {
        [orchestraButton, operaButton, balletButton, modernDanceButton].forEach {
            buttonStackView1.addArrangedSubview($0)
        }
        
        [traditionalDanceButton, koreanTraditionalMusicButton].forEach {
            buttonStackView2.addArrangedSubview($0)
        }
        
        [buttonStackView1, buttonStackView2].forEach {
            verticalStackView.addArrangedSubview($0)
        }
        
        [titleLabel, verticalStackView].forEach {
            addSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
        }
        
        verticalStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview()
        }
        
        buttonStackView1.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview().inset(40)
            $0.height.equalTo(32)
        }
        
        buttonStackView2.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.height.equalTo(32)
            $0.width.equalTo(135)
        }
    }
    
    override func bind() {
        inputPreferenceClassic
            .subscribe(with: self, onNext: { owner, type in
                owner.toggleButton(type)
            })
            .disposed(by: disposeBag)
    }
}

extension PreferenceClassicView {
    enum PreferenceClassicButtonType: String {
        case orchestra = "orchestra"
        case opera = "opera"
        case ballet = "ballet"
        case modernDance = "modernDance"
        case traditionalDance = "traditionalDance"
        case koreanTraditionalMusic = "koreanTraditionalMusic"
    }
    
    var inputPreferenceClassic: Observable<String> {
        return Observable.merge(
            orchestraButton.rx.tap.map { PreferenceClassicButtonType.orchestra.rawValue },
            operaButton.rx.tap.map { PreferenceClassicButtonType.opera.rawValue },
            balletButton.rx.tap.map { PreferenceClassicButtonType.ballet.rawValue },
            modernDanceButton.rx.tap.map { PreferenceClassicButtonType.modernDance.rawValue },
            traditionalDanceButton.rx.tap.map { PreferenceClassicButtonType.traditionalDance.rawValue },
            koreanTraditionalMusicButton.rx.tap.map { PreferenceClassicButtonType.koreanTraditionalMusic.rawValue }
        )
    }
}

private extension PreferenceClassicView {
    func toggleButton(_ field: String) {
        if let buttonType = PreferenceClassicButtonType(rawValue: field) {
            let button: OnboardingButton
            switch buttonType {
            case .orchestra:
                button = orchestraButton
            case .opera:
                button = operaButton
            case .ballet:
                button = balletButton
            case .modernDance:
                button = modernDanceButton
            case .traditionalDance:
                button = traditionalDanceButton
            case .koreanTraditionalMusic:
                button = koreanTraditionalMusicButton
            }
            button.isSelected.toggle()
        }
    }
}
