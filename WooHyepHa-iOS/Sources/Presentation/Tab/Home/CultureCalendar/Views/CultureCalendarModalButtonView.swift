//
//  CultureCalendarModelButtonView.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/16/24.
//

import UIKit
import RxSwift
import RxCocoa
import Then
import SnapKit

class CultureCalendarModalButtonView: BaseView {
    
    var isSelected: Bool = false {
        didSet {
            updateUI()
        }
    }
    
    var buttonTitle: String = "" {
        didSet {
            sortButton.setTitle(buttonTitle, for: .normal)
        }
    }
    
    private let sortButton = UIButton().then {
        $0.setTitleColor(.gray2, for: .normal)
        $0.titleLabel?.font = .body2
        $0.contentHorizontalAlignment = .left
    }
    
    private let checkImageView = UIImageView().then {
        $0.image = .checkActive
        $0.contentMode = .scaleAspectFit
        $0.isHidden = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        showTopBorder = false
        showBottomBorder = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setView() {
        [sortButton, checkImageView].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraints() {
        sortButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(checkImageView.snp.leading)
        }
        
        checkImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.width.height.equalTo(20)
        }
    }
    
    private func updateUI() {
        sortButton.setTitleColor(isSelected ? .MainColor : .gray2, for: .normal)
        checkImageView.isHidden = !isSelected
    }
}

extension CultureCalendarModalButtonView {
    var inputSortButton: Observable<Void> {
        sortButton.rx.tap
            .asObservable()
    }
}
