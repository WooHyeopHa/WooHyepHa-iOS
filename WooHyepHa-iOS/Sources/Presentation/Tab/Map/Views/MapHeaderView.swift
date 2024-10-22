//
//  MapHeaderView.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/22/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

class MapHeaderView: BaseHeaderView {
    
    private let searchButton = UIButton().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 22
        $0.clipsToBounds = true
        
        $0.setTitle("검색어를 입력해주세요", for: .normal)
        $0.setTitleColor(.gray6, for: .normal)
        $0.titleLabel?.font = .body2

        $0.setImage(.mapSearch, for: .normal)
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 7)
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 7, bottom: 0, right: -7)
        
        $0.contentHorizontalAlignment = .left
        $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        $0.semanticContentAttribute = .forceLeftToRight
        $0.addViewShadow(shadowRadius: 5.0, shadowOpacity: 0.1)
    }
    
    private let filterButton = UIButton().then {
        $0.setImage(.mapFilter, for: .normal)
        $0.layer.cornerRadius = 22
        $0.clipsToBounds = true
        $0.backgroundColor = .white
        $0.addViewShadow(shadowRadius: 5.0, shadowOpacity: 0.2)
    }

    private let buttonStackView =  UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillProportionally
        $0.spacing = 8
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: SetUp HeaderView
    override func setHeaderView() {
        backgroundColor = .clear
        
        [searchButton, filterButton].forEach {
            buttonStackView.addArrangedSubview($0)
        }
        
        addSubview(buttonStackView)
        
        showBottomBorder = false
    }
    
    override func setConstraints() {
        buttonStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        filterButton.snp.makeConstraints {
            $0.width.equalTo(44)
        }
        
        [searchButton, filterButton].forEach {
            $0.snp.makeConstraints {
                $0.height.equalTo(44)
            }
        }
    }
}

extension MapHeaderView {
    var inputSearchButton: Observable<Void> {
        searchButton.rx.tap
            .asObservable()
    }
    
    var inputFilterButton: Observable<Void> {
        filterButton.rx.tap
            .asObservable()
    }
}

