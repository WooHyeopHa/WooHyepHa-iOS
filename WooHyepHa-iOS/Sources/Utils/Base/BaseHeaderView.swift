//
//  BaseHeaderView.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/14/24.
//

import UIKit

import RxSwift
import Then

class BaseHeaderView: UIView {

    final let disposeBag = DisposeBag()
    
    var showBottomBorder: Bool = true {
        didSet {
            bottomBorder.isHidden = !showBottomBorder
        }
    }
    
    private let bottomBorder = CALayer().then {
        $0.backgroundColor = UIColor.gray9.cgColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setHeaderView()
        setConstraints()
        layer.addSublayer(bottomBorder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
           super.layoutSubviews()
           bottomBorder.frame = CGRect(x: 0, y: frame.height - 1, width: frame.width, height: 1)
       }
    
    // MARK: SetUp HeaderView Method
        /// HeaderView의 기초를 설정합니다. (배경색상 등)
        /// ```
        /// func setHeaderView() {
        ///    backgroundColor = .white
        ///    // another codes ...
        /// }
        /// ```
        func setHeaderView() { }
    
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

}
