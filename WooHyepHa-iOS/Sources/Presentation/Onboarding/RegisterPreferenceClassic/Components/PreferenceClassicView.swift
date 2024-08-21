//
//  PreferenceClassicView.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/21/24.
//

import UIKit

import Then
import SnapKit
import RxCocoa
import RxSwift

class PreferenceClassicView: BaseView {
    
    private let orchestraButton = OnboardingButton(title: "오케스트라")
    private let chamberMusicButton = OnboardingButton(title: "실내악")
    private let soloButton = OnboardingButton(title: "독주")
    private let operaButton = OnboardingButton(title: "오페라")
    private let symphonyButton = OnboardingButton(title: "교향곡")
    private let sonataButton = OnboardingButton(title: "소나타")
    private let concertoButton = OnboardingButton(title: "협주곡")
    private let balletButton = OnboardingButton(title: "발레")
    private let modernDanceButton = OnboardingButton(title: "현대무용")
    private let traditionalDanceButton = OnboardingButton(title: "전통무용")
    private let lineDanceButton = OnboardingButton(title: "라인댄스")
    private let tapDanceButton = OnboardingButton(title: "탭댄스")
    
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
        $0.distribution = .fillEqually
        $0.spacing = 20
    }
    
    private var selectedExhibition: Set<String> = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setView() {
        showTopBorder = false
        showBottomBorder = false
        
        [orchestraButton, chamberMusicButton, soloButton].forEach {
            horizontalStackView1.addArrangedSubview($0)
        }
        
        [operaButton, symphonyButton, sonataButton].forEach {
            horizontalStackView2.addArrangedSubview($0)
        }
        
        [concertoButton, balletButton, modernDanceButton].forEach {
            horizontalStackView3.addArrangedSubview($0)
        }
        
        [traditionalDanceButton, lineDanceButton, tapDanceButton].forEach {
            horizontalStackView4.addArrangedSubview($0)
        }
        
        [horizontalStackView1, horizontalStackView2, horizontalStackView3, horizontalStackView4].forEach {
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
        
        [orchestraButton, chamberMusicButton, soloButton, operaButton, symphonyButton, sonataButton, concertoButton, balletButton, modernDanceButton, traditionalDanceButton, lineDanceButton, tapDanceButton].forEach {
            $0.snp.makeConstraints {
                $0.height.equalTo(48)
            }
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
        case chamberMusic = "chamberMusic"
        case solo = "solo"
        case opera = "opera"
        case symphony = "symphony"
        case sonata = "sonata"
        case concerto = "experimentDrama"
        case ballet = "ballet"
        case modernDance = "modernDance"
        case traditionalDance = "traditionalDance"
        case lineDance = "lineDance"
        case tapDance = "tapDance"
    }
    
    var inputPreferenceClassic: Observable<String> {
        return Observable.merge(
            orchestraButton.rx.tap.map { PreferenceClassicButtonType.orchestra.rawValue },
            chamberMusicButton.rx.tap.map { PreferenceClassicButtonType.chamberMusic.rawValue },
            soloButton.rx.tap.map { PreferenceClassicButtonType.solo.rawValue },
            operaButton.rx.tap.map { PreferenceClassicButtonType.opera.rawValue },
            symphonyButton.rx.tap.map { PreferenceClassicButtonType.symphony.rawValue },
            sonataButton.rx.tap.map { PreferenceClassicButtonType.sonata.rawValue },
            concertoButton.rx.tap.map { PreferenceClassicButtonType.concerto.rawValue },
            balletButton.rx.tap.map { PreferenceClassicButtonType.ballet.rawValue },
            modernDanceButton.rx.tap.map { PreferenceClassicButtonType.modernDance.rawValue },
            traditionalDanceButton.rx.tap.map { PreferenceClassicButtonType.traditionalDance.rawValue },
            lineDanceButton.rx.tap.map { PreferenceClassicButtonType.lineDance.rawValue },
            tapDanceButton.rx.tap.map { PreferenceClassicButtonType.tapDance.rawValue }
        )
    }
}

extension PreferenceClassicView {
    private func toggleButton(_ field: String) {
        if let buttonType = PreferenceClassicButtonType(rawValue: field) {
            let button: OnboardingButton
            switch buttonType {
            case .orchestra:
                button = orchestraButton
            case .chamberMusic:
                button = chamberMusicButton
            case .solo:
                button = soloButton
            case .opera:
                button = operaButton
            case .symphony:
                button = symphonyButton
            case .sonata:
                button = sonataButton
            case .concerto:
                button = concertoButton
            case .ballet:
                button = balletButton
            case .modernDance:
                button = modernDanceButton
            case .traditionalDance:
                button = traditionalDanceButton
            case .lineDance:
                button = lineDanceButton            
            case .tapDance:
                button = tapDanceButton
            }
            
            button.isSelected.toggle()
            
            if button.isSelected {
                selectedExhibition.insert(field)
            } else {
                selectedExhibition.remove(field)
            }
        }
    }
}
