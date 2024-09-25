//
//  LoginViewController.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/14/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

class SignInViewController: BaseViewController {
    
    private let viewModel: SignInViewModel
    
    // MARK: UI Components
    
    private let backgroundImageView = UIImageView().then {
        $0.image = .onboardingBg
        $0.contentMode = .scaleAspectFill
    }
    
    private let logo = UIImageView().then {
        $0.image = .woohyephaRoundLogo
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8.89
    }
    
    private let mainTitleLabel = UILabel().then {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.75
        
        let attributedString = NSMutableAttributedString(string: "Ready to\n", attributes: [
            .font: UIFont.poppinsMedium,
            .foregroundColor: UIColor.white,
            .paragraphStyle: paragraphStyle
        ])
        
        attributedString.append(NSAttributedString(string: "Find muse?", attributes: [
            .font: UIFont.poppinsMedium,
            .foregroundColor: UIColor.white,
            .paragraphStyle: paragraphStyle
        ]))
        
        $0.attributedText = attributedString
        $0.numberOfLines = 2
        $0.textAlignment = .left
    }
    
    private let subTitleLabel = UILabel().then {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.3
        
        let attributedString = NSMutableAttributedString(string: "주변의 숨겨진 문화예술을 발견하고\n", attributes: [
            .font: UIFont.body2,
            .foregroundColor: UIColor.gray8,
            .paragraphStyle: paragraphStyle
        ])
        
        attributedString.append(NSAttributedString(string: "함께할 뮤즈를 찾아보세요!", attributes: [
            .font: UIFont.body2,
            .foregroundColor: UIColor.gray8,
            .paragraphStyle: paragraphStyle
        ]))
        
        $0.attributedText = attributedString
        $0.numberOfLines = 2
        $0.textAlignment = .left
    }
    
    private let appleLoginButton = UIButton().then {
        $0.setImage(UIImage(named: "appleLoginButton"), for: .normal)
    }
    
    private let privacyPolicyLabel = UILabel().then {
        let attributedString = NSMutableAttributedString(string: "소셜 로그인 버튼을 눌러 개인정보처리방침에 동의합니다.")

        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.caption2,
            .foregroundColor: UIColor.gray7
        ]
        attributedString.addAttributes(attributes, range: NSRange(location: 0, length: attributedString.length))

        if let range = attributedString.string.range(of: "개인정보처리방침") {
            let nsRange = NSRange(range, in: attributedString.string)
            attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: nsRange)
            attributedString.addAttribute(.underlineColor, value: UIColor.gray7, range: nsRange)
        }

        $0.attributedText = attributedString
        $0.textAlignment = .center
    }
    
    init(viewModel: SignInViewModel) {
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
        view.backgroundColor = .black
        
        [backgroundImageView, logo, mainTitleLabel, subTitleLabel, appleLoginButton, privacyPolicyLabel].forEach {
            view.addSubview($0)
        }
    }
    
    override func setConstraints() {
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        logo.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(56)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.height.width.equalTo(40)
        }
        
        mainTitleLabel.snp.makeConstraints {
            $0.top.equalTo(logo.snp.bottom).offset(13)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.height.equalTo(116)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(mainTitleLabel.snp.bottom).offset(8)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        appleLoginButton.snp.makeConstraints {
            $0.bottom.equalTo(privacyPolicyLabel.snp.top)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(52)
        }
        
        privacyPolicyLabel.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(60)
        }
    }
    
    override func bind() {
        let input = SignInViewModel.Input(signInWithAppleButtonTapped: appleLoginButton.rx.tap.asObservable())
        _ = viewModel.bind(input: input)
    }
}

// MARK: bind

extension SignInViewController: OnboardingHeaderViewDelegate {
    func rightButtonDidTap() {
        print("testLog : ButtonTapped")
    }
}
