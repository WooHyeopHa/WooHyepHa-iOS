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
    
    private lazy var birthTextField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(string: "태어난 연도를 설정해 주세요!", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray5])
        $0.font = .body4
        $0.textColor = .gray1
        $0.layer.borderColor = UIColor.gray7.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        $0.leftViewMode = .always
        $0.delegate = self
        $0.tintColor = .clear
    }
    
    private lazy var yearPicker = UIPickerView().then {
        $0.delegate = self
        $0.dataSource = self
        $0.backgroundColor = .white
    }
    
    private let years = Array(1930...2009).map { String($0) }
    
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
        
        setupPicker()
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

private extension BirthInputView {
    func setupPicker() {
        birthTextField.inputView = yearPicker
        
        if let defaultYearIndex = years.firstIndex(of: "2000") {
            yearPicker.selectRow(defaultYearIndex, inComponent: 0, animated: false)
        }
    }
}

// MARK: View Method
extension BirthInputView {
}

//MARK: Observable
extension BirthInputView {
    var isValidBirth: Observable<Bool> {
        return birthTextField.rx.text.orEmpty.map { !$0.isEmpty }
    }
}

extension BirthInputView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.text = years[row]
        label.textAlignment = .center
        label.font = .body2
        label.textColor = .gray1
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 32
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        birthTextField.text = years[row]
    }
}

extension BirthInputView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return years.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return years[row]
    }
}

extension BirthInputView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}
