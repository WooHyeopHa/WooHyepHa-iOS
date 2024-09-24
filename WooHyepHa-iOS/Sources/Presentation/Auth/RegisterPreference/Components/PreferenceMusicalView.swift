//
//  RegisterPreferenceMusicalView.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/21/24.
//

import UIKit

import Then
import SnapKit
import RxCocoa
import RxSwift

class PreferenceMusicalView: BaseView {
    
    private let dramaButton = OnboardingButton(title: "드라마")
    private let comedyButton = OnboardingButton(title: "코메디")
    private let romanceButton = OnboardingButton(title: "로맨스")
    private let operaButton = OnboardingButton(title: "오페라")
    private let fantasyButton = OnboardingButton(title: "판타지")
    private let thrillerButton = OnboardingButton(title: "스릴러")
    private let experimentDramaButton = OnboardingButton(title: "실험극")
    private let historyDramaButton = OnboardingButton(title: "역사극")
    private let originalButton = OnboardingButton(title: "오리지널")
    private let creationButton = OnboardingButton(title: "창작")
    private let licenseButton = OnboardingButton(title: "라이선스")
    
    private let mainTitleLabel = UILabel().then {
        $0.text = "어떤 뮤지컬/연극을 선호하시나요?"
        $0.font = .h3
        $0.textColor = .gray1
    }
    
    private let subTitleLabel = UILabel().then {
        $0.text = "🎯딱 맞는 행사를 추천해드릴게요! 다시 수정할 수 있어요!"
        $0.font = .body4
        $0.textColor = .gray4
    }
    
    private let horizontalStackView1 = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 11
    }
    
    private let horizontalStackView2 = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 11
    }
    
    private let horizontalStackView3 = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 11
    }
    
    private let horizontalStackView4 = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 11
    }
    
    private let verticalStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 20
        $0.alignment = .leading
    }
    
    private let skipButton = UIButton().then {
        $0.setTitle("뮤지컬/연극 관심없음", for: .normal)
        $0.setTitleColor(.gray4, for: .normal)
        $0.titleLabel?.font = .body2
    }
    
    private var selectedMusical: Set<String> = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setView() {
        showTopBorder = false
        showBottomBorder = false
        
        [dramaButton, comedyButton, romanceButton].forEach {
            horizontalStackView1.addArrangedSubview($0)
        }
        
        [operaButton, fantasyButton, thrillerButton].forEach {
            horizontalStackView2.addArrangedSubview($0)
        }
        
        [experimentDramaButton, historyDramaButton, originalButton].forEach {
            horizontalStackView3.addArrangedSubview($0)
        }
        
        [creationButton, licenseButton].forEach {
            horizontalStackView4.addArrangedSubview($0)
        }
        
        [horizontalStackView1, horizontalStackView2, horizontalStackView3, horizontalStackView4].forEach {
            verticalStackView.addArrangedSubview($0)
        }
        
        [mainTitleLabel, subTitleLabel, verticalStackView, skipButton].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraints() {
        mainTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(mainTitleLabel.snp.bottom).offset(12)
        }
        
        verticalStackView.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(35)
            $0.width.equalToSuperview()
            $0.height.equalTo(252)
        }
        
        skipButton.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        [horizontalStackView1, horizontalStackView2, horizontalStackView3].forEach {
            $0.snp.makeConstraints {
                $0.horizontalEdges.equalToSuperview()
            }
        }
        
        horizontalStackView4.snp.makeConstraints {
            $0.width.equalTo(verticalStackView).multipliedBy(2.0/3.0).offset(-22/3)
        }
        
        [dramaButton, comedyButton, romanceButton, operaButton, fantasyButton, thrillerButton, experimentDramaButton, historyDramaButton, originalButton, creationButton, licenseButton].forEach {
            $0.snp.makeConstraints {
                $0.height.equalTo(48)
            }
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
        case opera = "opera"
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
            operaButton.rx.tap.map { PreferenceMusicalButtonType.opera.rawValue },
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

extension PreferenceMusicalView {
    private func toggleButton(_ field: String) {
        if let buttonType = PreferenceMusicalButtonType(rawValue: field) {
            let button: OnboardingButton
            switch buttonType {
            case .drama:
                button = dramaButton
            case .comedy:
                button = comedyButton
            case .romance:
                button = romanceButton
            case .opera:
                button = operaButton
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
            
            if button.isSelected {
                selectedMusical.insert(field)
            } else {
                selectedMusical.remove(field)
            }
        }
    }
}
