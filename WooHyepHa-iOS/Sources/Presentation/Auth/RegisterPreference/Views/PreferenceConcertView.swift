//
//  PreferenceConcertView.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/21/24.
//

import UIKit
import RxSwift
import RxCocoa
import Then
import SnapKit

class PreferenceConcertView: BaseView {
    
    private let popButton = OnboardingButton(title: "팝")
    private let hiphopButton = OnboardingButton(title: "랩/힙합")
    private let rockButton = OnboardingButton(title: "락/메탈")
    private let kpopButton = OnboardingButton(title: "케이팝")
    private let fanmeetingButton = OnboardingButton(title: "팬미팅")
    private let trotButton = OnboardingButton(title: "트로트")
    private let balladeButton = OnboardingButton(title: "발라드")
    private let indieButton = OnboardingButton(title: "인디")
    private let talkButton = OnboardingButton(title: "토크/강연")
    private let festivalButton = OnboardingButton(title: "페스티벌")
    
    private let titleLabel = UILabel().then {
        $0.text = "어떤 장르의 콘서트를 선호하시나요?"
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
        [popButton, hiphopButton, rockButton, kpopButton, fanmeetingButton].forEach {
            buttonStackView1.addArrangedSubview($0)
        }
        
        [trotButton, balladeButton, indieButton, talkButton].forEach {
            buttonStackView2.addArrangedSubview($0)
        }
        
        [festivalButton].forEach {
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
            $0.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(32)
        }
        
        buttonStackView2.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview().inset(70)
            $0.height.equalTo(32)
        }
        
        buttonStackView3.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.width.equalTo(75)
            $0.height.equalTo(32)
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
        case ballade = "ballade"
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
            balladeButton.rx.tap.map { PreferenceConcertButtonType.ballade.rawValue },
            indieButton.rx.tap.map { PreferenceConcertButtonType.indie.rawValue },
            talkButton.rx.tap.map { PreferenceConcertButtonType.talk.rawValue },
            festivalButton.rx.tap.map { PreferenceConcertButtonType.festival.rawValue }
        )
    }
}

private extension PreferenceConcertView {
    func toggleButton(_ field: String) {
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
            case .ballade:
                button = balladeButton
            case .indie:
                button = indieButton
            case .talk:
                button = talkButton
            case .festival:
                button = festivalButton
            }
            
            button.isSelected.toggle()
        }
    }
}

