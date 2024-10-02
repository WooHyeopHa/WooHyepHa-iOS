//
//  RegisterLocationViewController.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/19/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

struct LocationResult {
    let displayText: String
}

class RegisterLocationViewController: BaseViewController {

    private let viewModel: RegisterLocationViewModel

    //MARK: UI Components
    private lazy var headerView = OnboardingHeaderView().then {
        $0.backgroundColor = .white
        $0.rightButtonTitle = "건너뛰기"
        $0.rightButtonTitleColor = .gray4
    }

    private let mainTitleLabel = UILabel().then {
        $0.text = "위치 정보를 입력해주세요!"
        $0.font = .h2
        $0.textColor = .gray1
    }    
    
    private let subTitleLabel = UILabel().then {
        $0.text = "위치 정보는 구 단위로 표시되며, 다른 사용자에게 공개됩니다"
        $0.font = .body4
        $0.textColor = .gray4
    }
    
    private lazy var searchBar = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(string: "구, 동으로 검색", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray5])
        
        $0.font = .body4
        $0.textColor = .gray1
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .gray9
        
        let iconImage = UIImageView(frame: CGRect(x: 20, y: 12, width: 18, height: 18))
        iconImage.image = UIImage(named: "search")
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
        leftView.addSubview(iconImage)
        
        $0.leftViewMode = .always
        $0.leftView = leftView
        
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        $0.rightViewMode = .always
        $0.rightView = rightView
    }
    
    private let currentLocationSearchButton = UIButton().then {
        $0.setTitle("현재 위치로 찾기", for: .normal)
        $0.setTitleColor(.MainColor, for: .normal)
        $0.titleLabel?.font = .body3
    }

    private lazy var footerView = OnboardingFooterView().then {
        $0.showBottomBorder = false
        $0.showDisabledButton = true
        $0.disabledButtonTitle = "다음"
    }
    
    init(viewModel: RegisterLocationViewModel) {
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
        
        [headerView, mainTitleLabel, subTitleLabel, searchBar, currentLocationSearchButton, footerView].forEach {
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
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(48)
        }
        
        currentLocationSearchButton.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(16)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
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
        
        let input = RegisterLocationViewModel.Input(
            disableButtonTapped: footerView.inputDisabledButtonTapped.asObservable(),
            backButtonTapped: headerView.inputLeftButtonTapped.asObservable(),
            location: searchBar.rx.text.orEmpty.asObservable() // 수정 필요
        )
        
        let output = viewModel.bind(input: input)
        
        output.isDisableButtonEnabled
            .drive(with: self, onNext: { owner, isEnabled in
                owner.footerView.updateDisabledButtonState(isEnabled: isEnabled)
            })
            .disposed(by: disposeBag)
    }
}
