//
//  PreferenceExhibitionView.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/21/24.
//

import UIKit

import Then
import SnapKit
import RxCocoa
import RxSwift

class PreferenceExhibitionView: BaseView {

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
    
    private let mainTitleLabel = UILabel().then {
        $0.text = "어떤 장르의 전시회를 선호하시나요?"
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
        $0.spacing = 11
    }

    private let verticalStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 20
        $0.alignment = .leading
    }
    
    private let skipButton = UIButton().then {
        $0.setTitle("전시회 관심없음", for: .normal)
        $0.setTitleColor(.gray4, for: .normal)
        $0.titleLabel?.font = .body2
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
        
        [popupExpoButton, photoExpoButton, modernArtButton].forEach {
            horizontalStackView1.addArrangedSubview($0)
        }
        
        [installationArtButton, digitalArtButton, buildingExpoButton].forEach {
            horizontalStackView2.addArrangedSubview($0)
        }
                
        [decorationArtButton, cultureExpoButton, scienceExpoButton].forEach {
            horizontalStackView3.addArrangedSubview($0)
        }                
        
        horizontalStackView4.addArrangedSubview(historyExpoButton)
        
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
            $0.width.equalTo(verticalStackView).multipliedBy(1.0/3.0).offset(-22/3)
        }
        
        [popupExpoButton, photoExpoButton, modernArtButton, installationArtButton,
         digitalArtButton, buildingExpoButton, decorationArtButton, cultureExpoButton, scienceExpoButton,
         historyExpoButton].forEach {
            $0.snp.makeConstraints {
                $0.height.equalTo(48)
            }
        }
    }
    
    override func bind() {
        inputPreferenceExhibition
            .subscribe(with: self, onNext: { owner, type in
                owner.toggleButton(type)
            })
            .disposed(by: disposeBag)
    }
}

extension PreferenceExhibitionView {
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

extension PreferenceExhibitionView {
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
            
            if button.isSelected {
                selectedExhibition.insert(field)
            } else {
                selectedExhibition.remove(field)
            }
        }
    }
}
