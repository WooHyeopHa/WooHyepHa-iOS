//
//  PreferenceConcertView.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/21/24.
//

import UIKit

import Then
import SnapKit
import RxCocoa
import RxSwift

class PreferenceConcertView: BaseView {

    private let classicButton = OnboardingButton(title: "클래식")
    private let popButton = OnboardingButton(title: "팝")
    private let rockButton = OnboardingButton(title: "락/메탈")
    private let jazzButton = OnboardingButton(title: "재즈")
    private let hiphopButton = OnboardingButton(title: "랩/힙합")
    private let kpopButton = OnboardingButton(title: "K-팝")
    private let fanmeetingButton = OnboardingButton(title: "팬미팅")
    private let trotButton = OnboardingButton(title: "트로트")
    private let indieButton = OnboardingButton(title: "인디")
    private let talkButton = OnboardingButton(title: "토크/강연")
    private let festivalButton = OnboardingButton(title: "페스티벌")
    
    private let horizontalStackView1 = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.spacing = 8
    }
    
    private let horizontalStackView2 = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.spacing = 8
    }
    
    private let horizontalStackView3 = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.spacing = 8
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
        
        [classicButton, popButton, rockButton, jazzButton, hiphopButton].forEach {
            horizontalStackView1.addArrangedSubview($0)
        }
        
        [kpopButton, fanmeetingButton, trotButton, indieButton].forEach {
            horizontalStackView2.addArrangedSubview($0)
        }
                
        [talkButton, festivalButton].forEach {
            horizontalStackView3.addArrangedSubview($0)
        }
    
        [horizontalStackView1, horizontalStackView2, horizontalStackView3].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraints() {
        horizontalStackView1.snp.makeConstraints {
            $0.width.equalTo(329)
            $0.height.equalTo(36)
            $0.top.equalToSuperview()
        }
        
        horizontalStackView2.snp.makeConstraints {
            $0.width.equalTo(260)
            $0.height.equalTo(36)
            $0.top.equalTo(horizontalStackView1.snp.bottom).offset(8)
        }
        
        horizontalStackView3.snp.makeConstraints {
            $0.width.equalTo(163)
            $0.height.equalTo(36)
            $0.top.equalTo(horizontalStackView2.snp.bottom).offset(8)
        }
        
        popButton.snp.makeConstraints {
            $0.width.equalTo(41)
            $0.height.equalTo(36)
        }
        
        [jazzButton, indieButton, kpopButton].forEach {
            $0.snp.makeConstraints {
                $0.width.equalTo(52)
                $0.height.equalTo(36)
            }
        }
        
        [classicButton, fanmeetingButton, trotButton].forEach {
            $0.snp.makeConstraints {
                $0.width.equalTo(64)
                $0.height.equalTo(36)
            }
        }
        
        [rockButton, hiphopButton].forEach {
            $0.snp.makeConstraints {
                $0.width.equalTo(68)
                $0.height.equalTo(36)
            }
        }

        festivalButton.snp.makeConstraints {
            $0.width.equalTo(75)
            $0.height.equalTo(36)
        }
        
        talkButton.snp.makeConstraints {
            $0.width.equalTo(79)
            $0.height.equalTo(36)
        }
    }
    
    override func bind() {
        inputPreferenceConcert
            .subscribe(with: self, onNext: { owner, type in
                owner.toggleButton(type)
            })
            .disposed(by: disposeBag)
    }
}

extension PreferenceConcertView {
    enum PreferenceConcertButtonType: String {
        case classic = "classic"
        case pop = "pop"
        case rock = "rock"
        case jazz = "jazz"
        case hiphop = "hiphop"
        case kpop = "kpop"
        case fanmeeting = "fanmeeting"
        case trot = "trot"
        case indie = "indie"
        case talk = "talk"
        case festival = "festival"
    }
    
    var inputPreferenceConcert: Observable<String> {
        return Observable.merge(
            classicButton.rx.tap.map { PreferenceConcertButtonType.classic.rawValue },
            popButton.rx.tap.map { PreferenceConcertButtonType.pop.rawValue },
            rockButton.rx.tap.map { PreferenceConcertButtonType.rock.rawValue },
            jazzButton.rx.tap.map { PreferenceConcertButtonType.jazz.rawValue },
            hiphopButton.rx.tap.map { PreferenceConcertButtonType.hiphop.rawValue },
            kpopButton.rx.tap.map { PreferenceConcertButtonType.kpop.rawValue },
            fanmeetingButton.rx.tap.map { PreferenceConcertButtonType.fanmeeting.rawValue },
            trotButton.rx.tap.map { PreferenceConcertButtonType.trot.rawValue },
            indieButton.rx.tap.map { PreferenceConcertButtonType.indie.rawValue },
            talkButton.rx.tap.map { PreferenceConcertButtonType.talk.rawValue },
            festivalButton.rx.tap.map { PreferenceConcertButtonType.festival.rawValue }
        )
    }
}

extension PreferenceConcertView {
    private func toggleButton(_ field: String) {
        if let buttonType = PreferenceConcertButtonType(rawValue: field) {
            let button: OnboardingButton
            switch buttonType {
            case .classic:
                button = classicButton
            case .pop:
                button = popButton
            case .rock:
                button = rockButton
            case .jazz:
                button = jazzButton
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
