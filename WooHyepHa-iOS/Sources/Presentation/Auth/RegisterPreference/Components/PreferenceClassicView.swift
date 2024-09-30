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

class PreferenceClassicView: UIView {
    
    private let disposeBag = DisposeBag()
    
    private let popupExpoButton = OnboardingButton(title: "팝업 전시")
    private let photoExpoButton = OnboardingButton(title: "사진 전시")
    private let modernArtButton = OnboardingButton(title: "현대미술")
    private let installationArtButton = OnboardingButton(title: "설치미술")
    private let digitalArtButton = OnboardingButton(title: "디지털 아트")
    private let buildingExpoButton = OnboardingButton(title: "건축 전시")
    private let decorationArtButton = OnboardingButton(title: "장식미술")
    private let cultureExpoButton = OnboardingButton(title: "문화 전시")
    private let scienceExpoButton = OnboardingButton(title: "과학 전시")
    private let historyExpoButton = OnboardingButton(title: "역사 전시")
    
    private let titleLabel = UILabel().then {
        $0.text = "어떤 장르의 전시회를 선호하시나요?"
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
        setView()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setView() {
        [popupExpoButton, photoExpoButton, modernArtButton, installationArtButton].forEach {
            buttonStackView1.addArrangedSubview($0)
        }
        
        [digitalArtButton, buildingExpoButton, decorationArtButton, cultureExpoButton].forEach {
            buttonStackView2.addArrangedSubview($0)
        }
                
        [scienceExpoButton, historyExpoButton].forEach {
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
            //$0.height.equalTo(120)
            $0.horizontalEdges.equalToSuperview()
        }
        
        buttonStackView1.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(32)
        }
        
        buttonStackView2.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(32)
        }
        
        buttonStackView3.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.width.equalTo(170)
            $0.height.equalTo(32)
        }
    }
    
    private func bind() {
        inputPreferenceExhibition
            .subscribe(with: self, onNext: { owner, type in
                owner.toggleButton(type)
            })
            .disposed(by: disposeBag)
    }
}

extension PreferenceClassicView {
    enum PreferenceExhibitionButtonType: String {
        case popupExpo = "popupExpo"
        case photoExpo = "photoExpo"
        case modernArt = "modernArt"
        case installationArt = "installationArt"
        case digitalArt = "digitalArt"
        case buildingExpo = "buildingExpo"
        case decorationArt = "decorationArt"
        case cultureExpo = "cultureExpo"
        case scienceExpo = "scienceExpo"
        case historyExpo = "historyExpo"
    }
    
    var inputPreferenceExhibition: Observable<String> {
        return Observable.merge(
            popupExpoButton.rx.tap.map { PreferenceExhibitionButtonType.popupExpo.rawValue },
            photoExpoButton.rx.tap.map { PreferenceExhibitionButtonType.photoExpo.rawValue },
            modernArtButton.rx.tap.map { PreferenceExhibitionButtonType.modernArt.rawValue },
            installationArtButton.rx.tap.map { PreferenceExhibitionButtonType.installationArt.rawValue },
            digitalArtButton.rx.tap.map { PreferenceExhibitionButtonType.digitalArt.rawValue },
            buildingExpoButton.rx.tap.map { PreferenceExhibitionButtonType.buildingExpo.rawValue },
            decorationArtButton.rx.tap.map { PreferenceExhibitionButtonType.decorationArt.rawValue },
            cultureExpoButton.rx.tap.map { PreferenceExhibitionButtonType.cultureExpo.rawValue },
            scienceExpoButton.rx.tap.map { PreferenceExhibitionButtonType.scienceExpo.rawValue },
            historyExpoButton.rx.tap.map { PreferenceExhibitionButtonType.historyExpo.rawValue }
        )
    }
}

extension PreferenceClassicView {
    private func toggleButton(_ field: String) {
        if let buttonType = PreferenceExhibitionButtonType(rawValue: field) {
            let button: OnboardingButton
            switch buttonType {
            case .popupExpo:
                button = popupExpoButton
            case .photoExpo:
                button = photoExpoButton
            case .modernArt:
                button = modernArtButton
            case .installationArt:
                button = installationArtButton
            case .digitalArt:
                button = digitalArtButton
            case .buildingExpo:
                button = buildingExpoButton
            case .decorationArt:
                button = decorationArtButton
            case .cultureExpo:
                button = cultureExpoButton
            case .scienceExpo:
                button = scienceExpoButton
            case .historyExpo:
                button = historyExpoButton
            }
            
            button.isSelected.toggle()
            
//            if button.isSelected {
//                selectedExhibition.insert(field)
//            } else {
//                selectedExhibition.remove(field)
//            }
        }
    }
}


