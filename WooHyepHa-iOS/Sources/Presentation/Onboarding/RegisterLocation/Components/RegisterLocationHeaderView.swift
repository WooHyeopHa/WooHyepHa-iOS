//
//  RegisterLocationHeaderView.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/19/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

protocol RegisterLocationHeaderViewDelegate: AnyObject {
    func backButtonDidTap()
}

class RegisterLocationHeaderView: BaseHeaderView {

    weak var delegate: RegisterLocationHeaderViewDelegate?
    
    // MARK: UI Components
    private let backButton = UIButton().then {
        $0.setImage(UIImage(named: "chevron_leftarrow")?.withTintColor(.gray1, renderingMode: .alwaysOriginal), for: .normal)
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
        backgroundColor = .white
        addSubview(backButton)
    }
    
    override func setConstraints() {
        backButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.width.height.equalTo(24)
        }
    }
}

private extension RegisterLocationHeaderView {
    func bind() {
        backButton.rx.tap
            .subscribe(with: self, onNext: { owner, _ in
                owner.delegate?.backButtonDidTap()
            })
            .disposed(by: disposeBag)
    }
}



