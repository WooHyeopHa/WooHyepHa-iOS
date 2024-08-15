//
//  RegisterProfileViewController.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/15/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

class RegisterProfileViewController: BaseViewController {

    weak var coordinator: OnboardingCoordinator?
    
    //MARK: UI Components
    private lazy var headerView = RegisterProfileHeaderView().then {
        $0.delegate = self
        $0.showBottomeBorder = false
    }
    
    private let mainTitleLabel = UILabel().then {
        $0.text = "프로필 정보를 입력해주세요!"
        $0.textColor = .gray1
        $0.font = .h2
    }
    
    private let subTitleLabel = UILabel().then {
        $0.text = "등록된 정보는 마이페이지에서 수정하실 수 있습니다!"
        $0.textColor = .gray4
        $0.font = .body4
    }
    
    private let addProfileImageButton = UIButton().then {
        $0.setImage(UIImage(named: "tabbar_mypage_active"), for: .normal)
        $0.backgroundColor = .gray7
        
        $0.layer.borderWidth = 3.5
        $0.layer.borderColor = UIColor.gray9.cgColor
        $0.layer.cornerRadius = 66
        $0.layer.masksToBounds = true
    }
    
    private let addProfileImageSubButton = UIButton().then {
        $0.setImage(UIImage(named: "camera")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        $0.backgroundColor = .gray5
        
        $0.layer.cornerRadius = 16
        $0.layer.masksToBounds = true
    }
    
    private let nicknameInputView = NicknameInputView()
    private let birthLabel = UILabel().then {
        $0.text = "닉네임"
        $0.font = .body1
        $0.textColor = .gray1
    }
    
    private let birthTextField = UITextField().then {
        $0.placeholder = "태어난 연도를 설정해 주세요!"
    }
    
    private let sexLabel = UILabel().then {
        $0.text = "성별"
        $0.font = .body1
        $0.textColor = .gray1
    }
    
    private let maleButton = UIButton().then {
        $0.setTitle("남성", for: .normal)
        $0.setTitleColor(.gray4, for: .normal)
        $0.backgroundColor = .white
    }
    
    private let femaleButton = UIButton().then {
        $0.setTitle("여성", for: .normal)
        $0.setTitleColor(.gray4, for: .normal)
        $0.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }

    // MARK: Set ViewController
    override func setViewController() {
        view.backgroundColor = .white
        
        [headerView, mainTitleLabel, subTitleLabel, addProfileImageButton, addProfileImageSubButton,
         nicknameInputView].forEach {
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
            $0.top.equalTo(headerView.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(32)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(mainTitleLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(20)
        }
        
        addProfileImageButton.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(34)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.width.height.equalTo(132)
        }
        
        addProfileImageSubButton.snp.makeConstraints {
            $0.bottom.equalTo(addProfileImageButton.snp.bottom).inset(10)
            $0.trailing.equalTo(addProfileImageButton.snp.trailing)
            $0.width.height.equalTo(32)
        }
        
        nicknameInputView.snp.makeConstraints {
            $0.top.equalTo(addProfileImageButton.snp.bottom).offset(29)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(91)
        }
    }
}

private extension RegisterProfileViewController {
    func bind() {
        // 테스트 로직임 수정 예정
        nicknameInputView.inputNickname
            .subscribe(with: self, onNext: { owner, text in
                if text == "중복" {
                    owner.nicknameInputView.updateState(isDuplicate: true)
                } else {
                    owner.nicknameInputView.updateState(isDuplicate: false)
                }
            })
            .disposed(by: disposeBag)
    }
}

extension RegisterProfileViewController: RegisterProfileHeaderViewDelegate {
    func backButtonDidTap() {
        print("test Log: Button Tapped")
    }
}
