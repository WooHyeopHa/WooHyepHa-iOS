//
//  LoginViewController.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/14/24.
//

import UIKit

class LoginViewController: BaseViewController {

    // 나중에 로그인 기능 구현 시 코디네이터는 뷰모델로 옮겨 주입 받을 예정
    weak var coordinator: OnboardingCoordinator?
    
    // MARK: UI Components
    private lazy var headerView = LoginHeaderView().then {
        $0.delegate = self
        $0.showBottomeBorder = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK: Set ViewController
    override func setViewController() {
        view.backgroundColor = .black
        
        [headerView].forEach {
            view.addSubview($0)
        }
    }
    
    override func setConstraints() {
        headerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(56)
        }
    }
}

extension LoginViewController: LoginHeaderViewDelegate {
    func leftButtonDidTap() {
        print("testLog : ButtonTapped")
    }
}
