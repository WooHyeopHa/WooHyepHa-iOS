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
    
    private let popButton = OnboardingButton(title: "팝")
    private let hiphopButton = OnboardingButton(title: "랩/힙합")
    private let rockButton = OnboardingButton(title: "락/메탈")
    private let kpopButton = OnboardingButton(title: "K-팝")
    private let fanmeetingButton = OnboardingButton(title: "팬미팅")
    private let trotButton = OnboardingButton(title: "트로트")
    private let indieButton = OnboardingButton(title: "인디")
    private let talkButton = OnboardingButton(title: "토크/강연")
    private let festivalButton = OnboardingButton(title: "페스티벌")
    
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
        
        [popButton, hiphopButton, rockButton].forEach {
            horizontalStackView1.addArrangedSubview($0)
        }
        
        [kpopButton, fanmeetingButton, trotButton].forEach {
            horizontalStackView2.addArrangedSubview($0)
        }
        
        [indieButton, talkButton, festivalButton].forEach {
            horizontalStackView3.addArrangedSubview($0)
        }
        
        [horizontalStackView1, horizontalStackView2, horizontalStackView3].forEach {
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
        
        [popButton, hiphopButton, rockButton, kpopButton, fanmeetingButton, trotButton, indieButton, talkButton, festivalButton].forEach {
            $0.snp.makeConstraints {
                $0.height.equalTo(48)
            }
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
    
    var inputPreferenceConcert: Observable<String> {
        return Observable.merge(
            popButton.rx.tap.map { PreferenceConcertButtonType.pop.rawValue },
            rockButton.rx.tap.map { PreferenceConcertButtonType.rock.rawValue },
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
