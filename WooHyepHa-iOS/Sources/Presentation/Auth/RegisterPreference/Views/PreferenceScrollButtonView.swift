//
//  PreferenceScrollButtonView.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 9/30/24.
//

import UIKit
import RxSwift
import RxCocoa
import Then
import SnapKit

class PreferenceScrollButtonView: BaseView {
    
    private var selectedButton: BottomBorderButton?
    
    private let exbitScrollButton = BottomBorderButton(title: "전시회",  updateAppearanceTextColor: .gray2)
    private let concertScrollButton = BottomBorderButton(title: "콘서트",  updateAppearanceTextColor: .gray2)
    private let musicalScrollButton = BottomBorderButton(title: "뮤지컬/연극",  updateAppearanceTextColor: .gray2)
    private let classicScrollButton = BottomBorderButton(title: "클래식/무용",  updateAppearanceTextColor: .gray2)
    
    private let bottomBorder = UIView().then {
        $0.backgroundColor = .gray8
    }
    
    private let buttonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.distribution = .fillProportionally
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setInitialState()
        showTopBorder = false
        showBottomBorder = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setView() {
        [exbitScrollButton, concertScrollButton, musicalScrollButton, classicScrollButton].forEach {
            buttonStackView.addArrangedSubview($0)
        }
        
        [buttonStackView, bottomBorder].forEach {
            addSubview($0)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalToSuperview()
        }
        bottomBorder.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
        
    }
    
    override func bind() {
        inputScrollButton
            .subscribe(with: self, onNext: { owner, type in
                owner.selectButton(type)
            })
            .disposed(by: disposeBag)
    }
    
    private func setInitialState() {
        exbitScrollButton.isSelected = true
        selectedButton = exbitScrollButton
    }
}

extension PreferenceScrollButtonView {
    enum scrollButtonType: String {
        case exhit = "exhit"
        case concert = "concert"
        case musical = "musical"
        case classic = "classic"
    }
    
    var inputScrollButton: Observable<String> {
        return Observable.merge(
            exbitScrollButton.rx.tap.map { scrollButtonType.exhit.rawValue },
            concertScrollButton.rx.tap.map { scrollButtonType.concert.rawValue },
            musicalScrollButton.rx.tap.map { scrollButtonType.musical.rawValue },
            classicScrollButton.rx.tap.map { scrollButtonType.classic.rawValue }
        )
    }
}

private extension PreferenceScrollButtonView {
    func selectButton(_ field: String) {
        if let buttonType = scrollButtonType(rawValue: field) {
            let button: BottomBorderButton
            switch buttonType {
            case .exhit:
                button = exbitScrollButton
            case .concert:
                button = concertScrollButton
            case .musical:
                button = musicalScrollButton
            case .classic:
                button = classicScrollButton
            }
            
            if button != selectedButton {
                selectedButton?.isSelected = false
                button.isSelected = true
                selectedButton = button
            }
        }
    }
}
