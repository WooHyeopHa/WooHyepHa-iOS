//
//  BaseViewController.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 7/31/24.
//

import UIKit

import RxSwift

class BaseViewController: UIViewController {
    
    final let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewController()
        setConstraints()
        bind()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: setUp ViewController Method
    /// ViewController의 기초를 설정합니다. (배경색상 등)
    /// ```
    /// func setViewController() {
    ///    self.view.backgroundColor = .white
    ///    // another codes ...
    /// }
    /// ```
    func setViewController() { }
    
    /// UI 프로퍼티의 제약조건을 설정합니다.
    /// (본 프로젝트에서는 Snapkit을 사용합니다.)
    /// ```
    /// func setConstraints() {
    ///    view.snp.makeConstraints {
    ///       $0.width.equalTo(10)
    ///    // another codes ...
    /// }
    /// ```
    func setConstraints() { }
    
    func bind() {}
}
