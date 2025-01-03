//
//  RegisterViewController.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/15/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

class SignUpViewController: BaseViewController {

    private let viewModel: SignUpViewModel
    
    //MARK: UI Components
    private lazy var headerView = OnboardingHeaderView().then {
        $0.backgroundColor = .white
        $0.showRightButton = true
        $0.rightButtonTitle = "건너뛰기"
    }
    
    private let mainTitleLabel = UILabel().then {
        $0.text = "가입을 축하드려요!"
        $0.textColor = .gray1
        $0.font = .body10
        $0.textAlignment = .left
    }
    
    private let subTitleLabel = UILabel().then {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.75
        
        let attributedString = NSMutableAttributedString(string: "프로필을 완성하면 내가 좋아하는 문화예술과\n", attributes: [
            .font: UIFont.body2,
            .foregroundColor: UIColor.gray2,
        ])
        
        attributedString.append(NSAttributedString(string: "딱 맞는 뮤즈를 발견할 수 있어요!", attributes: [
            .font: UIFont.body2,
            .foregroundColor: UIColor.gray2,
            .paragraphStyle: paragraphStyle
        ]))
        
        $0.attributedText = attributedString
        $0.numberOfLines = 2
        $0.textAlignment = .left
    }
    
    private let middleImageView = UIImageView().then {
        $0.image = .onboardingCelebrate
    }
    
    private lazy var footerView = OnboardingFooterView().then {
        $0.showBottomBorder = false
        $0.showEnabledButton = true
        $0.enabledButtonTitle = "프로필 완성하기"
    }
    
    init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Set ViewController
    override func setViewController() {
        view.backgroundColor = .white
        
        [headerView, mainTitleLabel, subTitleLabel, middleImageView, footerView].forEach {
            view.addSubview($0)
        }
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func setConstraints() {
        headerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(56)
        }
        
        mainTitleLabel.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(50)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(mainTitleLabel.snp.bottom)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(64)
        }        
        
        middleImageView.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(77)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(202)
            $0.width.equalTo(287)
        }
        
        footerView.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(60)
        }
    }
    
    override func bind() {
        headerView.inputRightButtonTapped
            .subscribe(with: self, onNext: { owner, _ in
                let modal = OnboardingSkipModalViewController()
                modal.showModal(vc: self)
            })
            .disposed(by: disposeBag)
        
        let input = SignUpViewModel.Input(
            backButtonTapped: headerView.inputLeftButtonTapped.asObservable(),
            nextButtonTapped: footerView.inputEnabledButtonTapped.asObservable()
        )
        
        _ = viewModel.bind(input: input)
    }
}
