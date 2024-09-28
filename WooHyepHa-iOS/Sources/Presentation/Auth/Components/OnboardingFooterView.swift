//
//  OnboardingFooterView.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/20/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

class OnboardingFooterView: BaseView {

    var disabledButtonTitle: String = "" {
        didSet {
            disabledButton.setTitle(disabledButtonTitle, for: .normal)
        }
    }    
    
    var showDisabledButton: Bool = false {
        didSet {
            disabledButton.isHidden = !showDisabledButton
        }
    }
    
    var enabledButtonTitle: String = "" {
        didSet {
            enabledButton.setTitle(enabledButtonTitle, for: .normal)
        }
    }
    
    var showEnabledButton: Bool = false {
        didSet {
            enabledButton.isHidden = !showEnabledButton
        }
    }
    
    // MARK: UI Components
    private let disabledButton = UIButton().then {
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .body2
        $0.backgroundColor = .gray6
        $0.layer.cornerRadius = 8
        $0.isEnabled = false
    }
    
    private let enabledButton = UIButton().then {
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .body2
        $0.backgroundColor = .gray1
        $0.layer.cornerRadius = 8
        $0.isHidden = true
    }
    
    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: SetUp View
    override func setView() {
        backgroundColor = .white
        [disabledButton, enabledButton].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraints() {
        disabledButton.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }        
        
        enabledButton.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }
    }
    
    override func bind() {
    }
}

// MARK: View Method
extension OnboardingFooterView {
    func updateDisabledButtonState(isEnabled: Bool) {
        disabledButton.isEnabled = isEnabled
        disabledButton.backgroundColor = isEnabled ? .gray1 : .gray6
    }
    
    var inputDisabledButtonTapped: Observable<Void> {
        disabledButton.rx.tap
            .asObservable()
    }
    
    var inputEnabledButtonTapped: Observable<Void> {
        enabledButton.rx.tap
            .asObservable()
    }
}
