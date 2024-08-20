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

class SexInputView: BaseView {

    private let selectedSex = PublishSubject<String>()
    
    // MARK: UI Components
    private let sexLabel = UILabel().then {
        $0.text = "성별"
        $0.font = .body1
        $0.textColor = .gray1
    }
    
    private let maleButton = UIButton().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray7.cgColor
        $0.layer.cornerRadius = 5
        
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = UIColor.white
        
        var titleContainer = AttributeContainer()
        titleContainer.font = UIFont.body4
        titleContainer.foregroundColor = UIColor.gray4
        configuration.attributedTitle = AttributedString("남성", attributes: titleContainer)
        
        $0.configuration = configuration
        $0.changesSelectionAsPrimaryAction = true
    }
    
    private let femaleButton = UIButton().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray7.cgColor
        $0.layer.cornerRadius = 5
        
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = UIColor.white
        
        var titleContainer = AttributeContainer()
        titleContainer.font = UIFont.body4
        titleContainer.foregroundColor = UIColor.gray4
        configuration.attributedTitle = AttributedString("여성", attributes: titleContainer)
        
        $0.configuration = configuration
        $0.changesSelectionAsPrimaryAction = true
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
        
        [maleButton, femaleButton].forEach {
            $0.configurationUpdateHandler = { button in
                let textColor: UIColor = button.state == .selected ? UIColor.MainColor : UIColor.gray4
                let backgroundColor: UIColor = button.state == .selected ? UIColor.MainColor.withAlphaComponent(0.1) : UIColor.white
                let borderColor: CGColor = button.state == .selected ? UIColor.MainColor.cgColor : UIColor.gray7.cgColor
                
                button.layer.borderColor = borderColor
                
                let attributesTransformer = UIConfigurationTextAttributesTransformer { attributes in
                    var updatedAttributes = attributes
                    updatedAttributes.foregroundColor = textColor
                    return updatedAttributes
                }
                
                var updatedConfiguration = button.configuration
                
                updatedConfiguration?.baseBackgroundColor = backgroundColor
                updatedConfiguration?.titleTextAttributesTransformer = attributesTransformer
                
                button.configuration?.baseBackgroundColor = backgroundColor
                button.configuration = updatedConfiguration
            }
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
    }
}

// MARK: View Method
extension SexInputView {
    func updateButton(field: String) {
        let allButtons = [maleButton, femaleButton]
        allButtons.forEach { $0.isSelected = false }
        
        if let buttonType = SexType(rawValue: field) {
            switch buttonType {
            case .male:
                maleButton.isSelected = true
                selectedSex.onNext("male")
            case .female:
                femaleButton.isSelected = true
                selectedSex.onNext("female")
            }
        }
    }
}

//MARK: Observable
extension SexInputView {
    enum SexType: String {
        case male = "male"
        case female = "female"
    }
    
    var inputSelectedSex: Observable<String> {
        return Observable.merge(
            maleButton.rx.tap.map { SexType.male.rawValue },
            femaleButton.rx.tap.map { SexType.female.rawValue }
        )
    }
    
    var isValidSex: Observable<Bool> {
        return selectedSex.map { !$0.isEmpty }
    }
}

