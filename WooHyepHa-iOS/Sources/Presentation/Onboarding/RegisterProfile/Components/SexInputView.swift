//
//  SexInputView.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/15/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

enum Sex {
    case male
    case female
}

class SexInputView: BaseView {

    private let selectedSex = PublishSubject<String>()
    
    // MARK: UI Components
    private let sexLabel = UILabel().then {
        $0.text = "성별"
        $0.font = .body1
        $0.textColor = .gray1
    }
    
    private let maleButton = UIButton().then {
        $0.setTitle("남성", for: .normal)
        $0.setTitleColor(.gray4, for: .normal)
        $0.titleLabel?.font = .body4
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray7.cgColor
        $0.layer.cornerRadius = 5
    }
    
    private let femaleButton = UIButton().then {
        $0.setTitle("여성", for: .normal)
        $0.setTitleColor(.gray4, for: .normal)
        $0.titleLabel?.font = .body4
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray7.cgColor
        $0.layer.cornerRadius = 5
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func setView() {
        backgroundColor = .white
        
        [sexLabel, maleButton, femaleButton].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraints() {
        sexLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(42)
        }
        
        maleButton.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalTo(160)
            $0.height.equalTo(42)
        }
        
        femaleButton.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(160)
            $0.height.equalTo(42)
        }
    }
    
    //MARK: Bind
    override func bind() {
        Observable.merge (
            maleButton.rx.tap.map { Sex.male },
            femaleButton.rx.tap.map { Sex.female }
        )
        .subscribe(with: self, onNext: { owner, sex in
            owner.updateButtonState(selected: sex)
        })
        .disposed(by: disposeBag)
    }
}

// MARK: View Method
extension SexInputView {
    private func updateButtonState(selected: Sex) {
        switch selected {
        case .male:
            maleButton.layer.borderColor = UIColor.MainColor.cgColor
            maleButton.setTitleColor(.MainColor, for: .normal)
            maleButton.backgroundColor = .MainColor.withAlphaComponent(0.1)
            femaleButton.layer.borderColor = UIColor.gray7.cgColor
            femaleButton.setTitleColor(.gray4, for: .normal)
            femaleButton.backgroundColor = .white
            selectedSex.onNext("male")
        case .female:
            maleButton.layer.borderColor = UIColor.gray7.cgColor
            maleButton.setTitleColor(.gray4, for: .normal)
            maleButton.backgroundColor = .white
            femaleButton.layer.borderColor = UIColor.MainColor.cgColor
            femaleButton.setTitleColor(.MainColor, for: .normal)
            femaleButton.backgroundColor = .MainColor.withAlphaComponent(0.1)
            selectedSex.onNext("female")
        }
    }
}

//MARK: Observable
extension SexInputView {
    var inputSelectedSex: Observable<String> {
        return selectedSex.asObservable()
    }
    
    var isValidSex: Observable<Bool> {
        return selectedSex.map { !$0.isEmpty }
    }
}

