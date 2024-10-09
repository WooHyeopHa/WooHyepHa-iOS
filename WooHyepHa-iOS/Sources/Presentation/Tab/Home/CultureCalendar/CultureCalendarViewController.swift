//
//  CultureCalendarViewController.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/9/24.
//

import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa

class CultureCalendarViewController: BaseViewController {

    weak var coordinator: HomeCoordinator?
    
    private let headerView = CultureCalendarHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setViewController() {
        view.backgroundColor = .white
        [headerView].forEach {
            view.addSubview($0)
        }
    }
    
    override func setConstraints() {
        headerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(56)
        }
    }
    
    override func bind() {
        headerView.inputNowButton
            .subscribe(with: self, onNext: { owner, _ in
                owner.coordinator?.pop()
            })
            .disposed(by: disposeBag)
    }

}
