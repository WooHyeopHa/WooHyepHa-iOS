//
//  CultureCalendarSortModalViewController.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/16/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

class CultureCalendarSortModalViewController: BaseViewController {

    private let mainTitleLabel = UILabel().then {
        $0.text = "정렬"
        $0.font = .sub4
        $0.textColor = .gray1
        $0.textAlignment = .left
    }
    
    private let borderView = UIView().then {
        $0.backgroundColor = .gray9
    }
    
    private let latestButtonView = CultureCalendarModalButtonView().then {
        $0.buttonTitle = "최신순"
    }
    
    private let popularityButtonView = CultureCalendarModalButtonView().then {
        $0.buttonTitle = "인기순"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateButtonStates(isLatestSelected: true)
    }
    
    override func setViewController() {
        view.backgroundColor = .white
        [mainTitleLabel, borderView, latestButtonView, popularityButtonView].forEach {
            view.addSubview($0)
        }
    }
    
    override func setConstraints() {
        mainTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(32)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        borderView.snp.makeConstraints {
            $0.top.equalTo(mainTitleLabel.snp.bottom).offset(16)
            $0.height.equalTo(1)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        latestButtonView.snp.makeConstraints {
            $0.top.equalTo(borderView.snp.bottom).offset(16)
            $0.height.equalTo(40)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }        
        
        popularityButtonView.snp.makeConstraints {
            $0.top.equalTo(latestButtonView.snp.bottom).offset(16)
            $0.height.equalTo(40)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    override func bind() {
        latestButtonView.inputSortButton
            .subscribe(with: self, onNext: { owner, _ in
                owner.updateButtonStates(isLatestSelected: true)
            })
            .disposed(by: disposeBag)        
        
        popularityButtonView.inputSortButton
            .subscribe(with: self, onNext: { owner, _ in
                owner.updateButtonStates(isLatestSelected: false)
            })
            .disposed(by: disposeBag)
    }
}

extension CultureCalendarSortModalViewController {
    func showModal(vc: UIViewController) {
        let modalVC = CultureCalendarSortModalViewController()
        
        if let sheet = modalVC.sheetPresentationController {
            let fixedDetent = UISheetPresentationController.Detent.custom { context in
                return 300
            }
            
            sheet.preferredCornerRadius = 30
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
            sheet.prefersGrabberVisible = false
            sheet.detents = [fixedDetent]
        }
        
        vc.present(modalVC, animated: true)
    }
}

private extension CultureCalendarSortModalViewController {
    func updateButtonStates(isLatestSelected: Bool) {
        latestButtonView.isSelected = isLatestSelected
        popularityButtonView.isSelected = !isLatestSelected
    }
}
