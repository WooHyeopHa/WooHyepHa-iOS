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

    weak var coordinator: OnboardingCoordinator?

    //MARK: UI Components
    private lazy var headerView = OnboardingHeaderView().then {
        $0.delegate = self
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
        $0.delegate = self
        $0.updateNextButtonState(isEnabled: true)
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
}

extension RegisterLocationViewController: OnboardingHeaderViewDelegate {
    func leftButtonDidTap() {
        coordinator?.pop()
    }
    
    func rightButtonDidTap() {
        print("testLog: rightButton Tapped")
    }
}

extension RegisterLocationViewController: OnboardingFooterViewDelegate {
    func nextButtonDidTap() {
        print("testLog: nextButton Tapped")
        coordinator?.goToRegisterPreferenceCultureViewController()
    }
}


// 1. 저런 주소를 전부다 스크롤링해서 서버를 하나 만들던지
// 2. MapKit << iOS 기본 제공인데, 뭐 제가 다른 맵을 사용해보던지
// 3. 마지막 방법 : 사용자에게 가이드라인 제시
// 4. 네

// 어떻게든 검색 가능하게 해서 완성하면 구~동까지 하고
// 이게 안되면 그 저 선택으로 가서 시만 선택하게 하기 (서울, 광역시, 세종시, 제주)

