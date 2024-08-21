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
        
        addSubview(verticalStackView)
    }
    
    override func setConstraints() {
        verticalStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalToSuperview()
        }
        
        [dramaButton, comedyButton, romanceButton, operaButton, fantasyButton, thrillerButton, experimentDramaButton, historyDramaButton, originalButton, creationButton, licenseButton].forEach {
            $0.snp.makeConstraints {
                $0.height.equalTo(48)
            }
        }
        
        [creationButton, licenseButton].forEach {
            $0.snp.makeConstraints {
                $0.width.equalTo(verticalStackView).multipliedBy(1.0/3.0).offset(-22/3)
                $0.left.equalTo(verticalStackView.snp.left)
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
        case pop = "pop"
        case hiphop = "hiphop"
        case rock = "rock"
        case kpop = "kpop"
        case fanmeeting = "fanmeeting"
        case trot = "trot"
        case indie = "indie"
        case talk = "talk"
        case festival = "festival"
    }
    
    var inputPreferenceMusical: Observable<String> {
        return Observable.merge(
            dramaButton.rx.tap.map { PreferenceMusicalButtonType.pop.rawValue },
            comedyButton.rx.tap.map { PreferenceMusicalButtonType.rock.rawValue },
            romanceButton.rx.tap.map { PreferenceMusicalButtonType.hiphop.rawValue },
            operaButton.rx.tap.map { PreferenceMusicalButtonType.kpop.rawValue },
            fantasyButton.rx.tap.map { PreferenceMusicalButtonType.fanmeeting.rawValue },
            thrillerButton.rx.tap.map { PreferenceMusicalButtonType.trot.rawValue },
            experimentDramaButton.rx.tap.map { PreferenceMusicalButtonType.indie.rawValue },
            historyDramaButton.rx.tap.map { PreferenceMusicalButtonType.talk.rawValue },
            originalButton.rx.tap.map { PreferenceMusicalButtonType.festival.rawValue },
            originalButton.rx.tap.map { PreferenceMusicalButtonType.festival.rawValue },
        )
    }
}

extension PreferenceMusicalView {
    private func toggleButton(_ field: String) {
        if let buttonType = PreferenceConcertButtonType(rawValue: field) {
            let button: OnboardingButton
            switch buttonType {
            case .pop:
                button = popButton
            case .rock:
                button = rockButton
            case .hiphop:
                button = hiphopButton
            case .kpop:
                button = kpopButton
            case .fanmeeting:
                button = fanmeetingButton
            case .trot:
                button = trotButton
            case .indie:
                button = indieButton
            case .talk:
                button = talkButton
            case .festival:
                button = festivalButton
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
