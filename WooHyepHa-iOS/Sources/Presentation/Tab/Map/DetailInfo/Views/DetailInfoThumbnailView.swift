//
//  DetailInfoThumbnailView.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 12/2/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

class DetailInfoThumbnailView: BaseView {
    
    private let backgroundThumbnailOverlayView = UIView().then {
        $0.backgroundColor = .black.withAlphaComponent(0.5)
    }
    
    private let backgroundThumbnailImageView = UIImageView()
    
    private let thumbnailImageView = UIImageView()
    
    private let findmuseButton = UIButton().then {
        // 기본 설정
        $0.backgroundColor = .gray1
        
        // 왼쪽 아이콘 이미지 설정
        $0.setImage(.detailArtFindButton, for: .normal)
        
        // 텍스트 설정
        $0.setTitle("함께할 뮤즈를 찾아보세요!", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .body4
        
        // 오른쪽 화살표 아이콘
        let chevronImage = UIImage(systemName: "chevron.right")
        $0.setImage(chevronImage, for: .normal)
        
        // 내부 여백 설정
        $0.contentEdgeInsets = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
        
        // 아이콘과 텍스트 사이 간격 설정
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 8)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: SetUp HeaderView
    override func setView() {
        backgroundColor = .clear
        backgroundThumbnailImageView.addSubview(backgroundThumbnailOverlayView)
        
        [backgroundThumbnailImageView, thumbnailImageView, findmuseButton].forEach {
            addSubview($0)
        }
        
        showBottomBorder = false
    }
    
    override func setConstraints() {
        backgroundThumbnailImageView.snp.makeConstraints {
            $0.verticalEdges.horizontalEdges.equalToSuperview()
        }
        
        backgroundThumbnailOverlayView.snp.makeConstraints {
            $0.horizontalEdges.equalTo(backgroundThumbnailImageView)
            $0.verticalEdges.equalTo(backgroundThumbnailImageView)
        }
        
        findmuseButton.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(0.13)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        thumbnailImageView.snp.makeConstraints {
            $0.bottom.equalTo(findmuseButton.snp.top).offset(-18)
            $0.height.equalToSuperview().multipliedBy(0.438)
            $0.width.equalToSuperview().multipliedBy(0.259)
            $0.leading.equalToSuperview().offset(20)
        }
    }
}

extension DetailInfoThumbnailView {
    func configuration(item: DetailArtData) {
        backgroundThumbnailImageView.setImageKingfisher(with: item.poster.replacingOccurrences(of: "http://", with: "https://"))        
        
        thumbnailImageView.setImageKingfisher(with: item.poster.replacingOccurrences(of: "http://", with: "https://"))
    }
}

