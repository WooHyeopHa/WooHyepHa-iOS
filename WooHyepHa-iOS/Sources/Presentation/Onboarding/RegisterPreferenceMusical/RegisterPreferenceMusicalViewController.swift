//
//  RegisterPreferenceMusicalViewController.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/21/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

class RegisterPreferenceMusicalViewController: BaseViewController {

    weak var coordinator: OnboardingCoordinator?

    //MARK: UI Components
    private lazy var headerView = OnboardingHeaderView().then {
        $0.delegate = self
        $0.backgroundColor = .white
        $0.rightButtonTitle = "건너뛰기"
        $0.rightButtonTitleColor = .gray4
    }

    private let progressView = OnboardingProgressView(progressValue: 0.3333)
    
    private let mainTitle = UILabel().then {
        $0.text = "어떤 장르의 뮤지컬/연극을 선호하시나요?"
        $0.textColor = .gray1
        $0.font = .sub1
    }
    
    private lazy var preferenceMusicalView = PreferenceMusicalView()
    
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
        
        [headerView, progressView, mainTitle, preferenceMusicalView, subTitle, footerView].forEach {
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
        
        mainTitle.snp.makeConstraints {
            $0.top.equalTo(progressView.snp.bottom).offset(28)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        preferenceMusicalView.snp.makeConstraints {
            $0.top.equalTo(mainTitle.snp.bottom).offset(32)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(252)
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
        var selected: [String] = []
        preferenceMusicalView.inputPreferenceMusical
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

extension RegisterPreferenceMusicalViewController: OnboardingHeaderViewDelegate {
    func leftButtonDidTap() {
        coordinator?.pop()
    }
    
    func rightButtonDidTap() {
        print("testLog: rightButton Tapped")
    }
}

extension RegisterPreferenceMusicalViewController: OnboardingFooterViewDelegate {
    func nextButtonDidTap() {
        print("testLog: nextButton Tapped")
        coordinator?.goToRegisterPreferenceConcertViewController()
    }
}
