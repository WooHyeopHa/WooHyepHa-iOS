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
        $0.font = .num1
        $0.textColor = .gray2
    }
    
    private let nickNameCountLabel = UILabel().then {
        $0.text = "0/10"
        $0.font = .body6
        $0.textColor = .gray5
        $0.textAlignment = .right
    }
    
    private lazy var nickNameTextField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(string: "사용하실 닉네임을 입력해 주세요!", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray5])
        $0.font = .body9
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 4, height: 0))
        $0.leftViewMode = .always
        $0.textColor = .gray1
        $0.delegate = self
    }
    
    private let bottomLine = CALayer().then {
        $0.backgroundColor = UIColor.gray10.cgColor
    }

    private let warningMessageLabel = UILabel().then {
        $0.text = "이미 사용중인 닉네임이에요"
        $0.textColor = .borderRed
        $0.font = .body4
        $0.textAlignment = .left
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bottomLine.frame = CGRect(x: 0, y: nickNameTextField.frame.height - 1, width: nickNameTextField.frame.width, height: 1)
        nickNameTextField.layer.addSublayer(bottomLine)
    }

    override func setView() {
        backgroundColor = .white
        
        [nickNameLabel, nickNameCountLabel, nickNameTextField, warningMessageLabel].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraints() {
        nickNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(40)
        }
        
        nickNameCountLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }
        
        nickNameTextField.snp.makeConstraints {
            $0.top.equalTo(nickNameLabel.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }        
        
        warningMessageLabel.snp.makeConstraints {
            $0.top.equalTo(nickNameTextField.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(32)
        }
    }
    
    //MARK: Bind
    override func bind() {
        nickNameTextField.rx.text.orEmpty
            .subscribe(with: self, onNext: { owner, nickname in
                owner.nickNameTextField.layer.borderColor = UIColor.gray7.cgColor
                owner.nickNameCountLabel.textColor = .gray5
                owner.nickNameCountLabel.text = "\(nickname.count)/10"
            })
            .disposed(by: disposeBag)
    }
}

// MARK: View Method
extension NicknameInputView {
    func handleDuplicateNickname(isDuplicate: Bool) {
        if isDuplicate {
            bottomLine.backgroundColor = UIColor.borderRed.cgColor
            nickNameTextField.layer.borderColor = UIColor.borderRed.cgColor
            warningMessageLabel.isHidden = false
        } else {
            bottomLine.backgroundColor = UIColor.gray10.cgColor
            warningMessageLabel.isHidden = true
        }
    }
}

//MARK: Observable
extension NicknameInputView {
    var inputNickname: Observable<String> {
        nickNameTextField.rx.text.orEmpty
            .asObservable()
    }
    
    var isValidNickname: Observable<Bool> {
        return Observable.combineLatest(
            inputNickname,
            nickNameTextField.rx.text.orEmpty.map { !$0.isEmpty }
        )
        .map { !$0.0.isEmpty }
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
