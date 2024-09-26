//
//  OnboardingHeaderView.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/20/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

protocol OnboardingHeaderViewDelegate: AnyObject {
    func leftButtonDidTap()
    func rightButtonDidTap()
}

class OnboardingHeaderView: BaseHeaderView {

    weak var delegate: OnboardingHeaderViewDelegate?
    
    // MARK: UI Components

    private let leftButton = UIButton().then {
        $0.setImage(UIImage(named: "chevron_leftarrow")?.withTintColor(.gray1, renderingMode: .alwaysOriginal), for: .normal)
    }
        
    var showLeftButton: Bool = true {
        didSet {
            leftButton.isHidden = !showLeftButton
        }
    }
    
    private let rightButton = UIButton().then {
        $0.titleLabel?.font = .body4
        $0.setTitleColor(.gray4, for: .normal)
    }
    
    var rightButtonTitle: String = "" {
        didSet {
            rightButton.setTitle(rightButtonTitle, for: .normal)
        }
    }
    
    var rightButtonTitleColor: UIColor = .white {
        didSet {
            rightButton.setTitleColor(rightButtonTitleColor, for: .normal)
        }
    }
    
    var showRightButton: Bool = true {
        didSet {
            rightButton.isHidden = !showRightButton
        }
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
        [leftButton, rightButton].forEach {
            addSubview($0)
        }
        showBottomBorder = false
    }
    
    override func setConstraints() {
        leftButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(24)
            $0.leading.equalToSuperview().offset(20)
        }
        
        rightButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }
    }
}

private extension OnboardingHeaderView {
    func bind() {
        leftButton.rx.tap
            .subscribe(with: self, onNext: { owner, _ in
                owner.delegate?.leftButtonDidTap()
            })
            .disposed(by: disposeBag)
        
        rightButton.rx.tap
            .subscribe(with: self, onNext: { owner, _ in
                owner.delegate?.rightButtonDidTap()
            })
            .disposed(by: disposeBag)
    }
}

extension OnboardingHeaderViewDelegate {
    func leftButtonDidTap() {
    }
    
    func rightButtonDidTap() {
    }
}
