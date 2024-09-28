//
//  RegisterNicknameViewController.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 9/25/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

class RegisterNicknameViewController: BaseViewController {

    private let viewModel: RegisterNicknameViewModel
    
    //MARK: UI Components
    private let mainTitleLabel = UILabel().then {
        $0.text = "반가워요!"
        $0.textColor = .gray1
        $0.font = .body10
        $0.textAlignment = .left
    }
    
    private let subTitleLabel = UILabel().then {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.75
        
        let attributedString = NSMutableAttributedString(string: "저희가 어떻게\n", attributes: [
            .font: UIFont.body10,
            .foregroundColor: UIColor.gray1,
        ])
        
        attributedString.append(NSAttributedString(string: "불러드리면 될까요?", attributes: [
            .font: UIFont.body10,
            .foregroundColor: UIColor.gray1,
            .paragraphStyle: paragraphStyle
        ]))
        
        $0.attributedText = attributedString
        $0.numberOfLines = 2
        $0.textAlignment = .left
    }
    
    private let nicknameInputView = NicknameInputView().then {
        $0.showTopBorder = false
        $0.showBottomBorder = false
    }
    
    private lazy var footerView = OnboardingFooterView().then {
        $0.showBottomBorder = false
        $0.showDisabledButton = true
        $0.disabledButtonTitle = "다음"
    }
    
    init(viewModel: RegisterNicknameViewModel) {
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
        
        [mainTitleLabel, subTitleLabel, nicknameInputView, footerView].forEach {
            view.addSubview($0)
        }
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func setConstraints() {
        mainTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(69)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(48)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(mainTitleLabel.snp.bottom).offset(18)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(64)
        }        
        
        nicknameInputView.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(70)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(168)
        }
        
        footerView.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(60)
        }
    }
    
    override func bind() {
        let input = RegisterNicknameViewModel.Input(
            disableButtonTapped:  footerView.inputDisabledButtonTapped,
            nickName: nicknameInputView.inputNickname)
        
        let output = viewModel.bind(input: input)
        
        output.isDisableButtonEnabled
            .drive(with: self, onNext: { owner, isEnabled in
                owner.footerView.updateDisabledButtonState(isEnabled: isEnabled)
            })
            .disposed(by: disposeBag)
        
        output.isHandleDuplicateEnabled
            .drive(with: self, onNext: { owner, isDuplicate in
                owner.nicknameInputView.handleDuplicateNickname(isDuplicate: isDuplicate)
            })
            .disposed(by: disposeBag)
    }
}
