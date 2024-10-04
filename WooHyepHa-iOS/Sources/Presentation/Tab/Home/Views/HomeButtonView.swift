//
//  HomeButtonView.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/3/24.
//

import UIKit

import RxSwift
import RxCocoa
import Then
import SnapKit

class HomeButtonView: BaseView {
    
    private let selectedHomeTag = BehaviorSubject<String>(value: "")
    
    private let exhibitionButton = HomeButton(title: "전시회")
    private let concertButton = HomeButton(title: "콘서트")
    private let classicButton = HomeButton(title: "클래식/무용")
    private let musicalButton = HomeButton(title: "뮤지컬/연극")
    
    private var buttons: [HomeButton] {
        return [exhibitionButton, concertButton, classicButton, musicalButton]
    }
    
    private let editButton = UIButton().then {
        $0.setImage(.homeEdit, for: .normal)
    }
    
    private let buttonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.distribution = .fillProportionally
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
        [exhibitionButton, concertButton, classicButton, musicalButton].forEach {
            buttonStackView.addArrangedSubview($0)
        }
            
        [buttonStackView, editButton].forEach {
            addSubview($0)
        }
    
        buttonStackView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(editButton.snp.leading).offset(-8)
            $0.height.equalTo(32)
            $0.centerY.equalToSuperview()
        }
        
        editButton.snp.makeConstraints {
            $0.width.height.equalTo(16)
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
    //MARK: Bind
    override func bind() {
        selectedHomeType
            .subscribe(with: self) { owner, type in
                owner.updateButtonState(selected: type)
            }
            .disposed(by: disposeBag)
        
        // 초기 상태 설정 (옵션)
        updateButtonState(selected: HomeButtonType.exhibition.rawValue)
    }
}

// MARK: View Method
extension HomeButtonView {
    private func updateButtonState(selected: String) {
        buttons.forEach { button in
            button.isSelected = (button.titleLabel?.text == selected)
        }
        
        if let buttonType = HomeButtonType(rawValue: selected) {
            selectedHomeTag.onNext(buttonType.rawValue)
        }
    }
}

//MARK: Observable
extension HomeButtonView {
    enum HomeButtonType: String {
        case exhibition = "전시회"
        case concert = "콘서트"
        case classic = "클래식/무용"
        case musical = "뮤지컬/연극"
    }
    
    var selectedHomeType: Observable<String> {
        return Observable.merge(
            exhibitionButton.rx.tap.map { self.exhibitionButton.titleLabel?.text ?? "" },
            concertButton.rx.tap.map { self.concertButton.titleLabel?.text ?? "" },
            classicButton.rx.tap.map { self.classicButton.titleLabel?.text ?? "" },
            musicalButton.rx.tap.map { self.musicalButton.titleLabel?.text ?? "" }
        )
    }
    
    var inputHomeTag: Observable<String> {
        return selectedHomeTag
    }
}
