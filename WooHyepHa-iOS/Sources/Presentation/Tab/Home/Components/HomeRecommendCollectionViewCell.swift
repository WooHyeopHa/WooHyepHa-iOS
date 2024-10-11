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
    
    private let recommendLabel = UILabel().then {
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
    
    private let progressBar = UIProgressView().then {
        $0.progress = 0.1
        $0.trackTintColor = .gray5
        $0.progressViewStyle = .bar
        $0.progressTintColor = .gray7
    }
    
    private let progressLabel = UILabel().then {
        let attributedString = NSMutableAttributedString(string: "0", attributes: [
            .font: UIFont.num2,
            .foregroundColor: UIColor.white
        ])
        
        attributedString.append(NSAttributedString(string: "0", attributes: [
            .font: UIFont.num2,
            .foregroundColor: UIColor.gray5
        ]))
        
        $0.attributedText = attributedString
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
    
    func configuration(_ item: ArtRandomList, currentPage: Int, totalPages: Int) {
        thumbnailImageView.image = UIImage(named: item.poster)
        updatePage(currentPage: currentPage, totalPages: totalPages)
    }
    
    func updatePage(currentPage: Int, totalPages: Int) {
        progressBar.progress = Float(currentPage) / Float(totalPages)
        
        let attributedString = NSMutableAttributedString(string: "\(currentPage)", attributes: [
            .font: UIFont.num2,
            .foregroundColor: UIColor.white
        ])
        
        attributedString.append(NSAttributedString(string: " / \(totalPages)", attributes: [
            .font: UIFont.num2,
            .foregroundColor: UIColor.gray5
        ]))
        
        progressLabel.attributedText = attributedString
    }
}

extension HomeRecommendCollectionViewCell {
    private func setCell() {
        backgroundColor = .clear
        [thumbnailImageView, recommendLabel, progressBar, progressLabel].forEach {
            addSubview($0)
        }
    }
    
    private func setConstraint() {
        thumbnailImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        recommendLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(22)
            $0.bottom.equalToSuperview().inset(48)
        }
        
        progressBar.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(22)
            $0.bottom.equalToSuperview().inset(29.5)
            $0.width.equalTo(65)
            $0.height.equalTo(1)
        }
        
        progressLabel.snp.makeConstraints {
            $0.leading.equalTo(progressBar.snp.trailing).offset(8)
            $0.bottom.equalToSuperview().inset(20)
            $0.width.equalTo(30)
            $0.height.equalTo(20)
        }
    }
}
