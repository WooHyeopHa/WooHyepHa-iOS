//
//  RegisterPreferenceMusicalView.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/21/24.
//

import UIKit
import RxSwift
import RxCocoa
import Then
import SnapKit

class PreferenceMusicalView: BaseView {
    
    private let dramaButton = OnboardingButton(title: "드라마")
    private let comedyButton = OnboardingButton(title: "코메디")
    private let romanceButton = OnboardingButton(title: "로맨스")
    private let fantasyButton = OnboardingButton(title: "판타지")
    private let thrillerButton = OnboardingButton(title: "스릴러")
    private let experimentDramaButton = OnboardingButton(title: "실험극")
    private let historyDramaButton = OnboardingButton(title: "역사극")
    private let originalButton = OnboardingButton(title: "오리지널/내한")
    private let creationButton = OnboardingButton(title: "창작")
    private let licenseButton = OnboardingButton(title: "라이선스")
    
    private let titleLabel = UILabel().then {
        $0.text = "어떤 장르의 뮤지컬/연극을 선호하시나요?"
        $0.font = .body1
        $0.textColor = .gray2
    }
    
    private let buttonStackView1 = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.distribution = .fillEqually
    }
    
    private let buttonStackView2 = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.distribution = .fillProportionally
    }
    
    private let buttonStackView3 = UIStackView().then {
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
        [dramaButton, comedyButton, romanceButton, fantasyButton].forEach {
            buttonStackView1.addArrangedSubview($0)
        }
        
        [thrillerButton, experimentDramaButton, historyDramaButton, originalButton].forEach {
            buttonStackView2.addArrangedSubview($0)
        }
        
        [creationButton, licenseButton].forEach {
            buttonStackView3.addArrangedSubview($0)
        }
        
        [buttonStackView1, buttonStackView2, buttonStackView3].forEach {
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
            $0.trailing.equalToSuperview().inset(70)
            $0.height.equalTo(32)
        }
        
        originalButton.snp.makeConstraints {
            $0.width.equalTo(120)
        }
        
        buttonStackView2.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview().inset(35)
            $0.height.equalTo(32)
        }
        
        buttonStackView3.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.width.equalTo(135)
            $0.height.equalTo(32)
        }
    }
    
    override func bind() {
        inputPreferenceMusical
            .subscribe(with: self, onNext: { owner, type in
                owner.toggleButton(type)
            })
            .disposed(by: disposeBag)
    }
}

extension PreferenceMusicalView {
    enum PreferenceMusicalButtonType: String {
        case drama = "drama"
        case comedy = "comedy"
        case romance = "romance"
        case fantasy = "fantasy"
        case thriller = "thriller"
        case experimentDrama = "experimentDrama"
        case historyDrama = "historyDrama"
        case original = "original"
        case creation = "creation"
        case license = "license"
    }
    
    var inputPreferenceMusical: Observable<String> {
        return Observable.merge(
            dramaButton.rx.tap.map { PreferenceMusicalButtonType.drama.rawValue },
            comedyButton.rx.tap.map { PreferenceMusicalButtonType.comedy.rawValue },
            romanceButton.rx.tap.map { PreferenceMusicalButtonType.romance.rawValue },
            fantasyButton.rx.tap.map { PreferenceMusicalButtonType.fantasy.rawValue },
            thrillerButton.rx.tap.map { PreferenceMusicalButtonType.thriller.rawValue },
            experimentDramaButton.rx.tap.map { PreferenceMusicalButtonType.experimentDrama.rawValue },
            historyDramaButton.rx.tap.map { PreferenceMusicalButtonType.historyDrama.rawValue },
            originalButton.rx.tap.map { PreferenceMusicalButtonType.original.rawValue },
            creationButton.rx.tap.map { PreferenceMusicalButtonType.creation.rawValue },
            licenseButton.rx.tap.map { PreferenceMusicalButtonType.license.rawValue }
        )
    }
}

private extension PreferenceMusicalView {
    func toggleButton(_ field: String) {
        if let buttonType = PreferenceMusicalButtonType(rawValue: field) {
            let button: OnboardingButton
            switch buttonType {
            case .drama:
                button = dramaButton
            case .comedy:
                button = comedyButton
            case .romance:
                button = romanceButton
            case .fantasy:
                button = fantasyButton
            case .thriller:
                button = thrillerButton
            case .experimentDrama:
                button = experimentDramaButton
            case .historyDrama:
                button = historyDramaButton
            case .original:
                button = originalButton
            case .creation:
                button = creationButton
            case .license:
                button = licenseButton
            }
            
            button.isSelected.toggle()
        }
    }
}

