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
    
    var showTopBorder: Bool = true {
        didSet {
            topBorder.isHidden = !showTopBorder
        }
    }    
    
    var showBottomBorder: Bool = true {
        didSet {
            bottomBorder.isHidden = !showBottomBorder
        }
    }
    
    private let topBorder = CALayer().then {
        $0.backgroundColor = UIColor.gray9.cgColor
    }
    
    private let bottomBorder = CALayer().then {
        $0.backgroundColor = UIColor.gray9.cgColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
        setConstraints()
        bind()
        layer.addSublayer(topBorder)
        layer.addSublayer(bottomBorder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        topBorder.frame = CGRect(x: 0, y: 0, width: frame.width, height: 1)
        bottomBorder.frame = CGRect(x: 0, y: frame.height - 1, width: frame.width, height: 1)
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
