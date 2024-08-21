//
//  RegisterSelectPurposeViewController.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/21/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

class RegisterSelectPurposeViewController: BaseViewController {

    weak var coordinator: OnboardingCoordinator?

    //MARK: UI Components
    private lazy var headerView = OnboardingHeaderView().then {
        $0.delegate = self
        $0.backgroundColor = .white
        $0.rightButtonTitle = "건너뛰기"
        $0.rightButtonTitleColor = .gray4
    }

    private let progressView = OnboardingProgressView(progressValue: 1.0)
    
    private let mainTitle = UILabel().then {
        let attributedString = NSMutableAttributedString(string: "문화예술을 관람하는\n", attributes: [.font: UIFont.sub1, .foregroundColor: UIColor.gray1])
        attributedString.append(NSAttributedString(string: "주요 목적은 무엇인가요? (택1)", attributes: [.font: UIFont.sub1, .foregroundColor: UIColor.gray1]))
        $0.attributedText = attributedString
        $0.numberOfLines = 2
        $0.textAlignment = .left
    }
    
    private lazy var selectPurpseView = SelectPurposeView()
    
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
        $0.nextButtonTitle = "입장하기"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Set ViewController
    override func setViewController() {
        view.backgroundColor = .white
        
        [headerView, progressView, mainTitle, selectPurpseView, subTitle, footerView].forEach {
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
        
        selectPurpseView.snp.makeConstraints {
            $0.top.equalTo(mainTitle.snp.bottom).offset(32)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(312)
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
        selectPurpseView.inputSelectPurpose
            .subscribe(with: self, onNext: { owner, type in
                print(type)
            })
            .disposed(by: disposeBag)
    }
}

extension RegisterSelectPurposeViewController: OnboardingHeaderViewDelegate {
    func leftButtonDidTap() {
        coordinator?.pop()
    }
    
    func rightButtonDidTap() {
        print("testLog: rightButton Tapped")
    }
}

extension RegisterSelectPurposeViewController: OnboardingFooterViewDelegate {
    func nextButtonDidTap() {
        print("testLog: nextButton Tapped")
    }
}
