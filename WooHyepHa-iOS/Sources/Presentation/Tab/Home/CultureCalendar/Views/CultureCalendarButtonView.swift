//
//  CultureCalendarButtonView.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/14/24.
//

import UIKit
import RxSwift
import RxCocoa
import Then
import SnapKit

class CultureCalendarButtonView: BaseView {
    
    private let selectedCultureCalendarTag = BehaviorSubject<String>(value: "")
    
    private let allButton = CultureCalendarButton(title: "전체")
    private let exhibitionButton = CultureCalendarButton(title: "전시회")
    private let concertButton = CultureCalendarButton(title: "콘서트")
    private let classicButton = CultureCalendarButton(title: "클래식/무용")
    private let musicalButton = CultureCalendarButton(title: "뮤지컬/연극")
    
    private var buttons: [CultureCalendarButton] {
        return [allButton, exhibitionButton, concertButton, classicButton, musicalButton]
    }
    
    private let scrollView = UIScrollView().then {
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
    }
    
    private let buttonStackView = UIStackView().then {
        $0.backgroundColor = .clear
        $0.axis = .horizontal
        $0.spacing = 6
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
        backgroundColor = .gray9
        
        [allButton, exhibitionButton, concertButton, classicButton, musicalButton].forEach {
            buttonStackView.addArrangedSubview($0)
        }
        
        scrollView.addSubview(buttonStackView)
        
        addSubview(scrollView)
    }
    
    override func setConstraints() {
        scrollView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview()
            $0.verticalEdges.equalToSuperview()
        }
        
        buttonStackView.snp.makeConstraints {
            $0.horizontalEdges.equalTo(scrollView.snp.horizontalEdges)
            $0.height.equalTo(32)
            $0.centerY.equalTo(scrollView)
        }
        
        [allButton, exhibitionButton, concertButton, musicalButton, classicButton].forEach {
            $0.snp.makeConstraints {
                $0.height.equalTo(32)
            }
        }
    }
    
    override func bind() {
        selectedCultureCalendarType
            .subscribe(with: self) { owner, type in
                owner.updateButtonState(selected: type)
            }
            .disposed(by: disposeBag)
        
        updateButtonState(selected: cultureCalendarButtonType.all.rawValue)
    }
}


// MARK: View Method
extension CultureCalendarButtonView {
    private func updateButtonState(selected: String) {
        buttons.forEach { button in
            button.isSelected = (button.titleLabel?.text == selected)
        }
        
        if let buttonType = cultureCalendarButtonType(rawValue: selected) {
            selectedCultureCalendarTag.onNext(buttonType.rawValue)
        }
    }
}

//MARK: Observable
extension CultureCalendarButtonView {
    enum cultureCalendarButtonType: String {
        case all = "전체"
        case exhibition = "전시회"
        case concert = "콘서트"
        case classic = "클래식/무용"
        case musical = "뮤지컬/연극"
    }
    
    var selectedCultureCalendarType: Observable<String> {
        return Observable.merge(
            allButton.rx.tap.map { self.allButton.titleLabel?.text ?? "" },
            exhibitionButton.rx.tap.map { self.exhibitionButton.titleLabel?.text ?? "" },
            concertButton.rx.tap.map { self.concertButton.titleLabel?.text ?? "" },
            classicButton.rx.tap.map { self.classicButton.titleLabel?.text ?? "" },
            musicalButton.rx.tap.map { self.musicalButton.titleLabel?.text ?? "" }
        )
    }
    
    var inputCultureCalendarTag: Observable<String> {
        return selectedCultureCalendarTag
    }
}

extension CultureCalendarButtonView {
    var inputAllButton: Observable<Void> {
        allButton.rx.tap
            .asObservable()
    }   
    
    var inputExhibitionButton: Observable<Void> {
        exhibitionButton.rx.tap
            .asObservable()
    }
    
    var inputConcertButton: Observable<Void> {
        concertButton.rx.tap
            .asObservable()
    }
    
    var inputClassicButton: Observable<Void> {
        classicButton.rx.tap
            .asObservable()
    }
    
    var inputMusicalButton: Observable<Void> {
        musicalButton.rx.tap
            .asObservable()
    }
}
