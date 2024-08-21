//
//  RegisterPreferenceCultrueViewController.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/20/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

class RegisterPreferenceCultrueViewController: BaseViewController {

    weak var coordinator: OnboardingCoordinator?

    //MARK: UI Components
    private lazy var headerView = OnboardingHeaderView().then {
        $0.delegate = self
        $0.backgroundColor = .white
        $0.rightButtonTitle = "건너뛰기"
        $0.rightButtonTitleColor = .gray4
    }

    private let progressView = OnboardingProgressView(progressValue: 0.1667)
    
    private lazy var preferenceCultureView = PreferenceCultureView()
    
    private let subTitle = UILabel().then {
        $0.text = "나중에 다시 수정할 수 있어요!"
        $0.textAlignment = .center
        $0.textColor = .gray4
        $0.font = .body4
    }
    
    private lazy var footerView = OnboardingFooterView().then {
        $0.showBottomBorder = false
        $0.delegate = self
        $0.updateNextButtonState(isEnabled: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Set ViewController
    override func setViewController() {
        view.backgroundColor = .white
        
        [headerView, progressView, preferenceCultureView, subTitle, footerView].forEach {
            view.addSubview($0)
        }
    }
    
    override func setConstraints() {
        headerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(56)
        }
        
        progressView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(10)
            $0.height.equalTo(6)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        preferenceCultureView.snp.makeConstraints {
            $0.top.equalTo(progressView.snp.bottom).offset(15)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.bottom.equalTo(subTitle.snp.top).offset(-15)
        }
        
        subTitle.snp.makeConstraints {
            $0.bottom.equalTo(footerView.snp.top).offset(-18)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        footerView.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(75)
        }
    }
    
    override func bind() {
        preferenceCultureView.inputPreferenceCulture
            .subscribe(with: self, onNext: { owner, type in
            })
            .disposed(by: disposeBag)
        
        var selected: [String] = []
        
        preferenceCultureView.inputPreferenceCulture
            .subscribe(with: self, onNext: { owner, type in
                if let index = selected.firstIndex(of: type) {
                    selected.remove(at: index)
                } else {
                    selected.append(type)
                }
                
                print(selected)
            })
            .disposed(by: disposeBag)
    }
}

extension RegisterPreferenceCultrueViewController: OnboardingHeaderViewDelegate {
    func leftButtonDidTap() {
        coordinator?.pop()
    }
    
    func rightButtonDidTap() {
        print("testLog: rightButton Tapped")
    }
}

extension RegisterPreferenceCultrueViewController: OnboardingFooterViewDelegate {
    func nextButtonDidTap() {
        print("testLog: nextButton Tapped")
        coordinator?.goToRegisterPreferenceExhibitionViewController()
    }
}
