//
//  RegisterPreferenceViewController.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/22/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

class RegisterPreferenceViewController: BaseViewController {
    
    weak var coordinator: AuthCoordinator?
    
    private var currentStepIndex = 0
    private var stepViews: [UIView] = []
    
    private var selectedExhibition: [String] = []
    private var selectedConcert: [String] = []
    private var selectedMusical: [String] = []
    private var selectedClassic: [String] = []
    
    //MARK: UI Components
    private lazy var headerView = OnboardingHeaderView().then {
        $0.delegate = self
        $0.backgroundColor = .white
        $0.rightButtonTitle = "건너뛰기"
        $0.rightButtonTitleColor = .gray4
    }
    
    private let progressView = OnboardingProgressView(progressValue: 0.1667)
    
    private lazy var contentView = UIView()
    
    private lazy var preferenceExhibitionView = PreferenceExhibitionView()
    private lazy var preferenceConcertView = PreferenceConcertView()
    private lazy var preferenceMusicalView = PreferenceMusicalView()
    private lazy var preferenceClassicView = PreferenceClassicView()
    
    private lazy var footerView = OnboardingFooterView().then {
        $0.showBottomBorder = false
        $0.delegate = self
        //$0.updateNextButtonState(isEnabled: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSteps()
    }
    
    // MARK: Set ViewController
    override func setViewController() {
        view.backgroundColor = .white
        
        [headerView, progressView, contentView, footerView].forEach {
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
        
        contentView.snp.makeConstraints {
            $0.top.equalTo(progressView.snp.bottom).offset(30)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.bottom.equalTo(footerView.snp.top).offset(-15)
        }

        footerView.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(75)
        }
    }
    
    override func bind() {
        preferenceExhibitionView.inputPreferenceExhibition
            .subscribe(with: self, onNext: { owner, type in
                if let index = owner.selectedExhibition.firstIndex(of: type) {
                    owner.selectedExhibition.remove(at: index)
                } else {
                    owner.selectedExhibition.append(type)
                }
                
                self.footerView.updateNextButtonState(isEnabled: !self.selectedExhibition.isEmpty)
            })
            .disposed(by: disposeBag)
        
        preferenceConcertView.inputPreferenceConcert
            .subscribe(with: self, onNext: { owner, type in
                if let index = owner.selectedConcert.firstIndex(of: type) {
                    owner.selectedConcert.remove(at: index)
                } else {
                    owner.selectedConcert.append(type)
                }
                
                self.footerView.updateNextButtonState(isEnabled: !self.selectedConcert.isEmpty)
            })
            .disposed(by: disposeBag)
        
        preferenceMusicalView.inputPreferenceMusical
            .subscribe(with: self, onNext: { owner, type in
                if let index = owner.selectedMusical.firstIndex(of: type) {
                    owner.selectedMusical.remove(at: index)
                } else {
                    owner.selectedMusical.append(type)
                }
                
                self.footerView.updateNextButtonState(isEnabled: !self.selectedMusical.isEmpty)
            })
            .disposed(by: disposeBag)        
        
        preferenceClassicView.inputPreferenceClassic
            .subscribe(with: self, onNext: { owner, type in
                if let index = owner.selectedClassic.firstIndex(of: type) {
                    owner.selectedClassic.remove(at: index)
                } else {
                    owner.selectedClassic.append(type)
                }
                
                self.footerView.updateNextButtonState(isEnabled: !self.selectedClassic.isEmpty)
            })
            .disposed(by: disposeBag)
    }
    
}

private extension RegisterPreferenceViewController {
    func setupSteps() {
        stepViews = [
            preferenceExhibitionView,
            preferenceConcertView,
            preferenceMusicalView,
            preferenceClassicView
        ]
        
        showCurrentStep()
    }
    
    func showCurrentStep() {
        contentView.subviews.forEach { $0.removeFromSuperview() }
        let currentStepView = stepViews[currentStepIndex]
        contentView.addSubview(currentStepView)
        
        currentStepView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        let progress = Float(currentStepIndex + 1) / Float(stepViews.count)
        progressView.setProgress(progress, animated: true)
    }
    
    func moveToNextStep() {
        switch currentStepIndex {
        case 0:
            print("Selected : \(selectedExhibition)")
        case 1:
            print("Selected : \(selectedConcert)")
        case 2:
            print("Selected : \(selectedMusical)")
        case 3:
            print("Selected : \(selectedClassic)")
        default:
            break
        }
        
        currentStepIndex += 1
        if currentStepIndex < stepViews.count {
            showCurrentStep()
        } else {
            //handleSignUpCompletion()
        }
    }
    
    func moveToPreviousStep() {
        if currentStepIndex == 0 {
            coordinator?.pop()
        } else {
            currentStepIndex -= 1
            showCurrentStep()
        }
    }
    
    func handleSignUpCompletion() {
        print("Sign up completed!")
    }
}

extension RegisterPreferenceViewController: OnboardingHeaderViewDelegate {
    func leftButtonDidTap() {
        //coordinator?.pop()
        self.moveToPreviousStep()
    }
    
    func rightButtonDidTap() {
        print("testLog: rightButton Tapped")
    }
}

extension RegisterPreferenceViewController: OnboardingFooterViewDelegate {
    func nextButtonDidTap() {
        self.moveToNextStep()
    }
}
