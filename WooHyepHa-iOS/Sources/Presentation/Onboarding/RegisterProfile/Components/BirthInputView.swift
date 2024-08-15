//
//  BirthInputView.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/15/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

class BirthInputView: BaseView {

    // MARK: UI Components
    private let birthLabel = UILabel().then {
        $0.text = "출생연도"
        $0.font = .body1
        $0.textColor = .gray1
    }
    
    private let birthTextField = UITextField().then {
        $0.placeholder = "태어난 연도를 설정해 주세요!"
        $0.font = .body4
        $0.layer.borderColor = UIColor.gray7.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        $0.leftViewMode = .always
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func setView() {
        backgroundColor = .white
        
        [birthLabel, birthTextField].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraints() {
        birthLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(42)
        }
        
        birthTextField.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }
    }
    
    //MARK: Bind
    override func bind() {
    }
}

// MARK: View Method
extension BirthInputView {
}

//MARK: Observable
extension BirthInputView {
}

