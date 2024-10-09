//
//  OnboardingSkipModalViewController.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/2/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

class OnboardingSkipModalViewController: BaseViewController {

    private let skipImage = UIImageView().then {
        $0.image = .onboardingSkip
    }
    
    private let mainTitleLabel = UILabel().then {
        $0.text = "메인홈으로 이동하시겠습니까?"
        $0.font = .sub1
        $0.textColor = .gray1
        $0.textAlignment = .center
    }
    
    private let subTitleLabel = UILabel().then {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.35
        
        let attributedString = NSMutableAttributedString(string: "지금까지 입력한 정보가 사라져요.\n", attributes: [
            .font: UIFont.body2,
            .foregroundColor: UIColor.gray4,
            .paragraphStyle: paragraphStyle
        ])
        
        attributedString.append(NSAttributedString(string: "프로필을 완성해 다른 사용자들과 소통해보세요!", attributes: [
            .font: UIFont.body2,
            .foregroundColor: UIColor.gray4,
            .paragraphStyle: paragraphStyle
        ]))
        
        $0.attributedText = attributedString
        $0.numberOfLines = 2
        $0.textAlignment = .center
    }
    
    private let noButton = UIButton().then {
        $0.setTitle("아니오", for: .normal)
        $0.setTitleColor(.gray2, for: .normal)
        $0.titleLabel?.font = .body2
        $0.backgroundColor = .gray8
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }    
    
    private let yesButton = UIButton().then {
        $0.setTitle("이동", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .body2
        $0.backgroundColor = .gray1
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    private let buttonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 12
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setViewController() {
        view.backgroundColor = .white
        [skipImage, mainTitleLabel, subTitleLabel, buttonStackView].forEach {
            view.addSubview($0)
        }
        
        [noButton, yesButton].forEach {
            buttonStackView.addArrangedSubview($0)
        }
    }
    
    override func setConstraints() {
        skipImage.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(28)
            $0.width.height.equalTo(80)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        mainTitleLabel.snp.makeConstraints {
            $0.top.equalTo(skipImage.snp.bottom).offset(24)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(mainTitleLabel.snp.bottom).offset(12)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension OnboardingSkipModalViewController {
    func showModal(vc: UIViewController) {
        let modalVC = OnboardingSkipModalViewController()
        
        if let sheet = modalVC.sheetPresentationController {
            let fixedDetent = UISheetPresentationController.Detent.custom { context in
                return 300
            }
            
            sheet.preferredCornerRadius = 30
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
            sheet.prefersGrabberVisible = false
            sheet.detents = [fixedDetent]
        }
        
        vc.present(modalVC, animated: true)
    }
}
