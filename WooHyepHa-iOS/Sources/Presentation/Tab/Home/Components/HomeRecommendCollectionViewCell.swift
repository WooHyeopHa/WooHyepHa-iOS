//
//  HomeRecommendCollectionViewCell.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/3/24.
//

import UIKit

import Then
import SnapKit

class HomeRecommendCollectionViewCell: UICollectionViewCell {
    static let id: String = "HomeRecommendCollectionViewCell"
    
    // MARK: UI Components
    private let thumbnailImageView = UIImageView().then {
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = 10
        $0.contentMode = .scaleToFill
        $0.clipsToBounds = true
    }
    
    private let testLabel = UILabel().then {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.75
        
        let attributedString = NSMutableAttributedString(string: "독깨팔님을 위한\n", attributes: [
            .font: UIFont.sub1,
            .foregroundColor: UIColor.white,
        ])
        
        attributedString.append(NSAttributedString(string: "랜덤 문화예술을 준비했어요!", attributes: [
            .font: UIFont.sub1,
            .foregroundColor: UIColor.white,
            .paragraphStyle: paragraphStyle
        ]))
        
        $0.attributedText = attributedString
        $0.numberOfLines = 2
        $0.textAlignment = .left
    }
    
    var thumbnailImage: UIImage? {
        return thumbnailImageView.image
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
    
    func configuration(_ item: MokHome) {
        thumbnailImageView.image = UIImage(named: item.image)
    }
}

extension HomeRecommendCollectionViewCell {
    private func setCell() {
        backgroundColor = .clear
        addSubview(thumbnailImageView)
        addSubview(testLabel)
    }
    
    private func setConstraint() {
        thumbnailImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }       
        
        testLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(22)
            $0.bottom.equalToSuperview().inset(48)
        }
    }
}
