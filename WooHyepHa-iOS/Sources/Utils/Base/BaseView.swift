//
//  BaseView.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/15/24.
//

import UIKit

import RxSwift
import Then

class BaseView: UIView {
    
    final let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
        setConstraints()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: SetUp View Method
    /// View의 기초를 설정합니다. (배경색상 등)
    /// ```
    /// func setView() {
    ///    backgroundColor = .white
    ///    // another codes ...
    /// }
    /// ```
    func setView() { }
    
    /// UI 프로퍼티의 제약조건을 설정합니다.
    /// (본 프로젝트에서는 Snapkit을 사용합니다.)
    /// ```
    /// func setConstraints() {
    ///    button.snp.makeConstraints {
    ///       $0.width.equalTo(10)
    ///    // another codes ...
    /// }
    /// ```
    func setConstraints() { }
    
    func bind() { }
}
