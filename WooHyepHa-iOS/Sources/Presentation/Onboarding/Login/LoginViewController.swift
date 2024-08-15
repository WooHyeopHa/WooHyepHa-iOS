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

class LoginViewController: BaseViewController {

    // 나중에 로그인 기능 구현 시 코디네이터는 뷰모델로 옮겨 주입 받을 예정
    weak var coordinator: OnboardingCoordinator?
    
    // MARK: UI Components
    private lazy var headerView = LoginHeaderView().then {
        $0.delegate = self
        $0.showBottomeBorder = false
    }
    
    private let mainTitleLabel = UILabel().then {
        let attributedString = NSMutableAttributedString(string: "주변의 숨겨진 문화예술을\n", attributes: [.font: UIFont.h2, .foregroundColor: UIColor.white])
        attributedString.append(NSAttributedString(string: "발견해보세요", attributes: [.font: UIFont.h2, .foregroundColor: UIColor.white]))
        $0.attributedText = attributedString
        $0.numberOfLines = 2
        $0.textAlignment = .center
    }
    
    private let subTitleLabel = UILabel().then {
        $0.text = "솔플은 이제 그만! 동행을 구해보는 건 어떨까요?"
        $0.textColor = .white
        $0.font = .body4
        $0.textAlignment = .center
    }
    
    private let appleLoginButton = UIButton().then {
        $0.setImage(UIImage(named: "appleLoginButton"), for: .normal)
    }
    
    private let privacyPolicyLabel = UILabel().then {
        $0.text = "소셜 로그인 버튼을 눌러 개인정보처리방침에 동의합니다."
        $0.textColor = .gray7
        $0.font = .caption2
        $0.textAlignment = .center
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    // MARK: Set ViewController
    override func setViewController() {
        view.backgroundColor = .black
        
        [headerView, mainTitleLabel, subTitleLabel, appleLoginButton, privacyPolicyLabel].forEach {
            view.addSubview($0)
        }
    }
    
    override func setConstraints() {
        headerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(56)
        }
        
        mainTitleLabel.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(32)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(80)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(mainTitleLabel.snp.bottom).offset(6)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(36)
        }
        
        appleLoginButton.snp.makeConstraints {
            $0.bottom.equalTo(privacyPolicyLabel.snp.top)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(48)
        }
        
        privacyPolicyLabel.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(60)
        }
    }
}

// MARK: bind
private extension LoginViewController {
    func bind() {
        appleLoginButton.rx.tap
            .subscribe(with: self, onNext: { owner, _ in
                owner.coordinator?.goToRegisterViewController()
            })
            .disposed(by: disposeBag)
    }
}

extension LoginViewController: LoginHeaderViewDelegate {
    func leftButtonDidTap() {
        print("testLog : ButtonTapped")
    }
}
