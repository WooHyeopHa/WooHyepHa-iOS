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

class RegisterViewController: BaseViewController {

    weak var coordinator: OnboardingCoordinator?
    
    //MARK: UI Components
    private let mainTitleLabel = UILabel().then {
        $0.text = "가입을 축하드립니다!"
        $0.textColor = .gray7
        $0.font = .h2
        $0.textAlignment = .center
    }
    
    private let subTitleLabel = UILabel().then {
        $0.text = "Let's find muse!"
        $0.textColor = .white
        $0.font = .body2
        $0.textAlignment = .center
    }
    
    private let registerButton = UIButton().then {
        $0.setTitle("프로필 등록하기", for: .normal)
        $0.setTitleColor(.gray2, for: .normal)
        $0.titleLabel?.font = .body2
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 5
    }
    
    private let nextRegisterButton = UIButton().then {
        let attributedString = NSMutableAttributedString(string: "다음에 등록할게요!", attributes: [.font: UIFont.body4, .foregroundColor: UIColor.gray8])
        attributedString.append(NSAttributedString(string: "   Skip", attributes: [.font: UIFont.body4, .foregroundColor: UIColor.MainColor]))
        $0.setAttributedTitle(attributedString, for: .normal)
        $0.titleLabel?.numberOfLines = 2
        $0.backgroundColor = .clear
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    // MARK: Set ViewController
    override func setViewController() {
        view.backgroundColor = .black
        
        [mainTitleLabel, subTitleLabel, registerButton, nextRegisterButton].forEach {
            view.addSubview($0)
        }
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func setConstraints() {
        mainTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(252)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(48)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(mainTitleLabel.snp.bottom)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(40)
        }
        
        registerButton.snp.makeConstraints {
            $0.bottom.equalTo(nextRegisterButton.snp.top)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(48)
        }
        
        nextRegisterButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(60)
        }
    }
}

// MARK: bind
private extension RegisterViewController {
    func bind() {
        registerButton.rx.tap
            .subscribe(with: self, onNext: { owner, _ in
                owner.coordinator?.goToRegisterProfileViewController()
            })
            .disposed(by: disposeBag)
    }
}
