//
//  RegisterProfileViewController.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/15/24.
//

import UIKit
import PhotosUI

import RxCocoa
import RxSwift
import SnapKit
import Then

class RegisterProfileViewController: BaseViewController {

    weak var coordinator: OnboardingCoordinator?
    
    //MARK: UI Components
    private lazy var headerView = OnboardingHeaderView().then {
        $0.delegate = self
        $0.backgroundColor = .white
        $0.showRightButton = false
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
        $0.imageView?.contentMode = .scaleAspectFill
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
    
    private let nicknameInputView = NicknameInputView().then {
        $0.showTopBorder = false
        $0.showBottomBorder = false
    }
    
    private let birthInputView = BirthInputView().then {
        $0.showTopBorder = false
        $0.showBottomBorder = false
    }
    
    private let sexInputView = SexInputView().then {
        $0.showTopBorder = false
        $0.showBottomBorder = false
    }
    
    private lazy var footerView = OnboardingFooterView().then {
        $0.showBottomBorder = false
        $0.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }

    // MARK: Set ViewController
    override func setViewController() {
        view.backgroundColor = .white
        
        [headerView, mainTitleLabel, subTitleLabel, addProfileImageButton, addProfileImageSubButton,
         nicknameInputView, birthInputView, sexInputView, footerView].forEach {
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
        
        birthInputView.snp.makeConstraints {
            $0.top.equalTo(nicknameInputView.snp.bottom).offset(18)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(91)
        }        
        
        sexInputView.snp.makeConstraints {
            $0.top.equalTo(birthInputView.snp.bottom).offset(18)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(85)
        }        
        
        footerView.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(75)
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
        
        let validNickname = nicknameInputView.inputNickname
            .filter { !$0.isEmpty && $0 != "중복" }
            .share(replay: 1)

        let selectedSex = sexInputView.inputSelectedSex
            .share(replay: 1)

        Observable.combineLatest(validNickname, selectedSex)
            .subscribe(onNext: { [weak self] (nickname, sex) in
                print("닉네임: \(nickname), 성별: \(sex)")
            })
            .disposed(by: disposeBag)
        
        Observable.combineLatest(
            nicknameInputView.isValidNickname,
            sexInputView.isValidSex,
            birthInputView.isValidBirth
        )
        .map { $0 && $1 && $2 }
        .bind(with: self) { owner, isValid in
            owner.footerView.updateNextButtonState(isEnabled: isValid)
        }
        .disposed(by: disposeBag)
        
        addProfileImageButton.rx.tap
            .subscribe(with: self, onNext: { owner, _ in
                owner.presentImagePicker()
            })
            .disposed(by: disposeBag)
        
        addProfileImageSubButton.rx.tap
            .subscribe(with: self, onNext: { owner, _ in
                owner.presentImagePicker()
            })
            .disposed(by: disposeBag)
    }
    
    func presentImagePicker() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
}

extension RegisterProfileViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let result = results.first else { return }
        
        result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (object, error) in
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
                return
            }
            
            result.itemProvider.loadFileRepresentation(forTypeIdentifier: UTType.image.identifier) { [weak self] (url, error) in
                if let error = error {
                    print("Error loading image URL: \(error.localizedDescription)")
                    return
                }
                
                guard let image = object as? UIImage else { return }
                
                DispatchQueue.main.async {
                    self?.addProfileImageButton.setImage(image, for: .normal)
                }
            }
        }
    }
}

extension RegisterProfileViewController: OnboardingHeaderViewDelegate {
    func leftButtonDidTap() {
        coordinator?.pop()
    }
}

extension RegisterProfileViewController: OnboardingFooterViewDelegate {
    func nextButtonDidTap() {
        coordinator?.goToRegisterLocationViewController()
    }
}

