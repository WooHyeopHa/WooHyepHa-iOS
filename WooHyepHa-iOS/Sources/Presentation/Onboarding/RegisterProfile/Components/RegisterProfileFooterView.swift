//
//  RegisterProfileFooterView.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/15/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

protocol RegisterProfileFooterViewDelegate: AnyObject {
    func nextButtonDidTap()
}

class RegisterProfileFooterView: BaseView {

    weak var delegate: RegisterProfileFooterViewDelegate?
    
    // MARK: UI Components
    private let nextButton = UIButton().then {
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .body2
        $0.backgroundColor = .gray1
        $0.layer.cornerRadius = 10
    }
    
    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        bind()
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
}
