//
//  RegisterPreferenceViewController.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/22/24.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class RegisterPreferenceViewController: BaseViewController {

    private let viewModel: RegisterPreferenceViewModel
    
    //MARK: UI Components
    private lazy var headerView = OnboardingHeaderView().then {
        $0.backgroundColor = .white
        $0.rightButtonTitle = "건너뛰기"
        $0.rightButtonTitleColor = .gray4
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "문화예술 취향 분석🎯"
        $0.font = .h3
        $0.textColor = .gray1
    }
    
    private let subTitleLabel = UILabel().then {
        $0.text = "관심사를 선택해주세요! 관심 없는 항목은 넘어가셔도 괜찮아요!"
        $0.font = .body4
        $0.textColor = .gray4
    }
    
    private let onboardingScrollButtonView = PreferenceScrollButtonView()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let preferenceExhibitionView = PreferenceExhibitionView()
    private let preferenceConcertView = PreferenceConcertView()
    private let preferenceMusicalView = PreferenceMusicalView()
    private let preferenceClassicView = PreferenceClassicView()

    private lazy var footerView = OnboardingFooterView().then {
        $0.showBottomBorder = false
        $0.showDisabledButton = true
        $0.disabledButtonTitle = "다음"
    }
    
    init(viewModel: RegisterPreferenceViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        [headerView, titleLabel, subTitleLabel, onboardingScrollButtonView, scrollView, footerView].forEach {
            view.addSubview($0)
        }
        
        scrollView.addSubview(contentView)
        
        [preferenceExhibitionView, preferenceConcertView, preferenceMusicalView, preferenceClassicView].forEach {
            contentView.addSubview($0)
        }
        
        setConstraint()
        bindScrollButton()
    }
    
    private func setConstraint() {
        headerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(56)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }

        onboardingScrollButtonView.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(25)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(48)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(onboardingScrollButtonView.snp.bottom)
            $0.left.right.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(footerView.snp.top)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        preferenceExhibitionView.snp.makeConstraints {
            $0.top.left.right.equalTo(contentView).inset(20)
            $0.height.equalTo(160)
        }
        
        preferenceConcertView.snp.makeConstraints {
            $0.top.equalTo(preferenceExhibitionView.snp.bottom).offset(40)
            $0.left.right.equalTo(contentView).inset(20)
            $0.height.equalTo(160)
        }
        
        preferenceMusicalView.snp.makeConstraints {
            $0.top.equalTo(preferenceConcertView.snp.bottom).offset(40)
            $0.left.right.equalTo(contentView).inset(20)
            $0.height.equalTo(160)
        }
        
        preferenceClassicView.snp.makeConstraints {
            $0.top.equalTo(preferenceMusicalView.snp.bottom).offset(40)
            $0.left.right.bottom.equalTo(contentView).inset(20)
            $0.height.equalTo(160)
        }
        
        footerView.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(75)
        }
    }

    override func bind() {
        headerView.inputRightButtonTapped
            .subscribe(with: self, onNext: { owner, _ in
                let modal = OnboardingSkipModalViewController()
                modal.showModal(vc: self)
            })
            .disposed(by: disposeBag)
        
        let input = RegisterPreferenceViewModel.Input(
            disableButtonTapped: footerView.inputDisabledButtonTapped.asObservable(),
            backButtonTapped: headerView.inputLeftButtonTapped.asObservable(),
            preferenceExhibitionButtonTapped: preferenceExhibitionView.inputPreferenceExhibition.asObservable(),
            preferenceConcertButtonTapped: preferenceConcertView.inputPreferenceConcert.asObservable(),
            preferenceMusicalButtonTapped: preferenceMusicalView.inputPreferenceMusical.asObservable(),
            preferenceClassicButtonTapped: preferenceClassicView.inputPreferenceClassic.asObservable()
        )
        
        let output = viewModel.bind(input: input)
        
        output.isDisableButtonEnabled
            .drive(with: self, onNext: { owner, isEnabled in
                owner.footerView.updateDisabledButtonState(isEnabled: isEnabled)
            })
            .disposed(by: disposeBag)
    }
}

private extension RegisterPreferenceViewController {
    func bindScrollButton() {
        onboardingScrollButtonView.inputScrollButton
            .subscribe(onNext: { [weak self] buttonType in
                guard let self = self else { return }
                let targetView: UIView
                switch buttonType {
                case "exhit": targetView = self.preferenceExhibitionView
                case "concert": targetView = self.preferenceConcertView
                case "musical": targetView = self.preferenceMusicalView
                case "classic": targetView = self.preferenceClassicView
                default: return
                }
                
                self.scrollView.setContentOffset(CGPoint(x: 0, y: targetView.frame.origin.y - 20), animated: true)
            })
            .disposed(by: disposeBag)
    }
}
