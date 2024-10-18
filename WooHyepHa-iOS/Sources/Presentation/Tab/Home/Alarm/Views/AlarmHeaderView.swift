//
//  AlarmHeaderView.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/18/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

class AlarmHeaderView: BaseHeaderView {
    
    private let backButton = UIButton().then {
        $0.setImage(UIImage(named: "chevron_leftarrow")?.withTintColor(.gray1, renderingMode: .alwaysOriginal), for: .normal)
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "알림"
        $0.font = .sub2
        $0.textColor = .gray1
        $0.textAlignment = .center
    }
    
    private let deleteButton = UIButton().then {
        $0.setTitle("전체삭제", for: .normal)
        $0.setTitleColor(.gray1, for: .normal)
        $0.titleLabel?.font = .body6
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setHeaderView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: SetUp HeaderView
    override func setHeaderView() {
        backgroundColor = .clear
        
        [backButton, titleLabel, deleteButton].forEach {
            addSubview($0)
        }
        
        showBottomBorder = false
    }
    
    override func setConstraints() {
        backButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.width.height.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
        }        
        
        deleteButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(64)
        }
    }
}

extension AlarmHeaderView {
    var inputBackButton: Observable<Void> {
        backButton.rx.tap
            .asObservable()
    }
    
    var inputDeleteButton: Observable<Void> {
        deleteButton.rx.tap
            .asObservable()
    }
}
