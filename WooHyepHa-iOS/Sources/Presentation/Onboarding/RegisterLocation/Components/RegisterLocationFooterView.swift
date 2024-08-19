//
//  RegisterLocationFooterView.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/19/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

protocol RegisterLocationFooterViewDelegate: AnyObject {
    func nextButtonDidTap()
}

class RegisterLocationFooterView: BaseView {

    weak var delegate: RegisterLocationFooterViewDelegate?
    
    // MARK: UI Components
    private let nextButton = UIButton().then {
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .body2
        $0.backgroundColor = .gray6
        $0.layer.cornerRadius = 10
        $0.isEnabled = false
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
        [nextButton].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraints() {
        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }
    }
    
    override func bind() {
        nextButton.rx.tap
            .subscribe(with: self, onNext: { owner, _ in
                owner.delegate?.nextButtonDidTap()
            })
            .disposed(by: disposeBag)
    }
}

// MARK: View Method
extension RegisterLocationFooterView {
    func updateNextButtonState(isEnabled: Bool) {
        nextButton.isEnabled = isEnabled
        nextButton.backgroundColor = isEnabled ? .gray1 : .gray6
    }
}
