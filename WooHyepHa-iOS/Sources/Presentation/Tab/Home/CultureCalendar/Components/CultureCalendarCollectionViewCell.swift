//
//  CultureCalendarCollectionViewCell.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/15/24.
//

import UIKit
import Then
import SnapKit

class CultureCalendarCollectionViewCell: UICollectionViewCell {
    static let id: String = "CultureCalendarCollectionViewCell"
    
    // MARK: UI Components
    private let thumbnailImageView = UIImageView().then {
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = 6.8
        $0.contentMode = .scaleToFill
        $0.clipsToBounds = true
    }
    
    private let genreLabel = UILabel().then {
        $0.backgroundColor = .gray9
        $0.font = .caption2
        $0.textColor = .gray2
        $0.textAlignment = .center
        $0.layer.cornerRadius = 11
        $0.clipsToBounds = true
    }
    
    private let likeButton = UIButton().then {
        $0.setImage(.homeHeart, for: .normal)
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .sub5
        $0.textColor = .gray1
        $0.textAlignment = .left
        $0.numberOfLines = 2
    }
    
    private let placeLabel = UILabel().then {
        $0.font = .body6
        $0.textColor = .gray1
        $0.textAlignment = .left
    }
    
    private let dateLabel = UILabel().then {
        $0.font = .body6
        $0.textColor = .gray5
        $0.textAlignment = .left
    }
    
    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCell()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configuration(_ item: ArtList) {
        thumbnailImageView.image = UIImage(named: item.poster)
        genreLabel.text = item.genre
        titleLabel.text = item.title
        placeLabel.text = item.place
        dateLabel.text = "\(item.startDate) ~ \(item.endDate)"
        
        item.liked ? likeButton.setImage(.heartActive, for: .normal) : likeButton.setImage(.homeHeart.withTintColor(.gray6), for: .normal)
    }
}

extension CultureCalendarCollectionViewCell {
    private func setCell() {
        backgroundColor = .clear
        [thumbnailImageView, genreLabel, likeButton, titleLabel, placeLabel, dateLabel].forEach {
            addSubview($0)
        }
    }
    
    private func setConstraint() {
        thumbnailImageView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.3)
        }
        
        genreLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(thumbnailImageView.snp.trailing).offset(10)
            $0.width.equalTo(69)
            $0.height.equalTo(22)
        }
        
        likeButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.height.equalTo(20)
            $0.trailing.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(genreLabel.snp.bottom).offset(8)
            $0.leading.equalTo(thumbnailImageView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().inset(5)
        }        
        
        placeLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalTo(thumbnailImageView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().inset(5)
        }        
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(placeLabel.snp.bottom).offset(8)
            $0.leading.equalTo(thumbnailImageView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().inset(5)
        }
    }
}
