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

    private let viewModel: RegisterProfileViewModel
    private var profileImageURL = BehaviorSubject<String>(value: "default_image_url")
    
    //MARK: UI Components
    private lazy var headerView = OnboardingHeaderView().then {
        $0.backgroundColor = .white
        $0.showRightButton = false
    }
    
    private let mainTitleLabel = UILabel().then {
        $0.text = "프로필을 채워보세요!"
        $0.textColor = .gray1
        $0.font = .h3
    }
    
    private let subTitleLabel = UILabel().then {
        $0.text = "등록된 정보는 마이페이지에서 수정하실 수 있습니다!"
        $0.textColor = .gray4
        $0.font = .body4
    }
    
    private let addProfileImageButton = UIButton().then {
        $0.setImage(.onboardingDefaultPhoto, for: .normal)
        $0.backgroundColor = .gray9
        $0.imageView?.contentMode = .scaleAspectFill
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray8.cgColor
        $0.layer.cornerRadius = 66
        $0.layer.masksToBounds = true
    }
    
    private let addProfileImageSubButton = UIButton().then {
        $0.setImage(.onboardingCamera, for: .normal)
        $0.layer.cornerRadius = 16
        $0.layer.masksToBounds = true
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
        $0.showDisabledButton = true
        $0.disabledButtonTitle = "다음"
    }
    
    init(viewModel: RegisterProfileViewModel) {
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
        
        [headerView, mainTitleLabel, subTitleLabel, addProfileImageButton, addProfileImageSubButton, birthInputView, sexInputView, footerView].forEach {
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
            $0.bottom.equalTo(addProfileImageButton.snp.bottom).inset(4.5)
            $0.trailing.equalTo(addProfileImageButton.snp.trailing).offset(3.5)
            $0.width.height.equalTo(32)
        }
        
        birthInputView.snp.makeConstraints {
            $0.top.equalTo(addProfileImageSubButton.snp.bottom).offset(31)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(91)
        }        
        
        sexInputView.snp.makeConstraints {
            $0.top.equalTo(birthInputView.snp.bottom).offset(23)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(85)
        }        
        
        footerView.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(75)
        }
    }
    
    override func bind() {
        // 테스트 로직임 수정 예정
        Observable.combineLatest(
            sexInputView.isEmpty,
            birthInputView.isEmpty
        )
        .map { $0 && $1 }
        .bind(with: self) { owner, isValid in
            owner.footerView.updateDisabledButtonState(isEnabled: isValid)
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
        
        let input = RegisterProfileViewModel.Input(
            disableButtonTapped: footerView.inputDisabledButtonTapped.asObservable(), 
            backButtonTapped: headerView.inputLeftButtonTapped,
            profileImageURL: profileImageURL.asObservable(),
            birth: birthInputView.inputBirth.asObservable(),
            sex: sexInputView.inputSex.asObservable()
        )
        
        let output = viewModel.bind(input: input)
        
        output.isDisableButtonEnabled
            .drive(with: self, onNext: { owner, isEnabled in
                owner.footerView.updateDisabledButtonState(isEnabled: isEnabled)
            })
            .disposed(by: disposeBag)
    }
}

private extension RegisterProfileViewController {
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
                
                let urlString = url?.absoluteString
                DispatchQueue.main.async {
                    self?.addProfileImageButton.setImage(image, for: .normal)
                    self?.profileImageURL.onNext(urlString ?? "default_image_url")
                }
            }
        }
    }
}
