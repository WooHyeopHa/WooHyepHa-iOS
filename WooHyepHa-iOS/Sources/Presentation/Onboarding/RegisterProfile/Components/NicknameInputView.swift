//
//  NicknameInputView.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/15/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

class NicknameInputView: BaseView {

    // MARK: UI Components
    private let nickNameLabel = UILabel().then {
        $0.text = "닉네임"
        $0.font = .body1
        $0.textColor = .gray1
    }
    
    private let nickNameCountLabel = UILabel().then {
        $0.text = "0/10"
        $0.font = .body4
        $0.textColor = .gray5
        $0.textAlignment = .right
    }
    
    private lazy var nickNameTextField = UITextField().then {
        $0.placeholder = "사용하실 닉네임을 입력해 주세요!"
        $0.font = .body4
        $0.layer.borderColor = UIColor.gray6.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        $0.leftViewMode = .always
    
        $0.delegate = self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func setView() {
        backgroundColor = .white
        
        [nickNameLabel, nickNameCountLabel, nickNameTextField].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraints() {
        nickNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.width.height.equalTo(42)
        }
        
        nickNameCountLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(150)
            $0.height.equalTo(42)
        }
        
        nickNameTextField.snp.makeConstraints {
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
extension NicknameInputView {
    func updateState(isDuplicate: Bool) {
        if isDuplicate {
            nickNameTextField.layer.borderColor = UIColor.borderRed.cgColor
            nickNameCountLabel.text = "중복된 닉네임입니다!"
            nickNameCountLabel.textColor = .borderRed
        } else {
            nickNameTextField.layer.borderColor = UIColor.gray6.cgColor
            nickNameCountLabel.textColor = .gray5
            nickNameCountLabel.text = "\(nickNameTextField.text?.count ?? 0)/10"
        }
    }
}

//MARK: Observable
extension NicknameInputView {
    var inputNickname: Observable<String> {
        nickNameTextField.rx.text.orEmpty
            .asObservable()
    }
}

extension NicknameInputView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

       if let char = string.cString(using: String.Encoding.utf8) {
              let isBackSpace = strcmp(char, "\\b")
              if isBackSpace == -92 {
                  return true
              }
        }
        guard textField.text!.count < 10 else { return false }
        return true
    }
}
