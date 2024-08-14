//
//  LoginHeaderView.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/14/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

protocol LoginHeaderViewDelegate: AnyObject {
    func leftButtonDidTap()
}

class LoginHeaderView: BaseHeaderView {

    weak var delegate: LoginHeaderViewDelegate?
    
    // MARK: UI Components
    private let leftButton = UIButton().then {
        $0.setTitle("둘러보기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 15)
    }
    
    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: SetUp HeaderView
    override func setHeaderView() {
        backgroundColor = .black
        addSubview(leftButton)
    }
    
    override func setConstraints() {
        leftButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }
    }
}

private extension LoginHeaderView {
    func bind() {
        leftButton.rx.tap
            .subscribe(with: self, onNext: { owner, _ in
                owner.delegate?.leftButtonDidTap()
            })
            .disposed(by: disposeBag)
    }
}
