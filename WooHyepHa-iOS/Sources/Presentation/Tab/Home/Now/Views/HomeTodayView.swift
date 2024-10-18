//
//  HomeTodayView.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/4/24.
//

import UIKit

import RxSwift
import RxCocoa
import Then
import SnapKit

class HomeTodayView: BaseView {
        
    private let mainDateLabel = UILabel().then {
        $0.backgroundColor = .gray11
        $0.layer.cornerRadius = 13.5
        $0.clipsToBounds = true
        $0.textAlignment = .center
        $0.numberOfLines = 0
        
        let attributedString = NSMutableAttributedString(string: "24\n", attributes: [
            .font: UIFont.caption1,
            .foregroundColor: UIColor.white,
        ])
        
        attributedString.append(NSAttributedString(string: "수", attributes: [
            .font: UIFont.num3,
            .foregroundColor: UIColor.white
        ]))
        
        $0.attributedText = attributedString
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .caption1
        $0.textColor = .gray1
        $0.text = "NELL CLUB CONCERT 2024 'Our Eutopia AAAAAAAAAAAAAAA'"
        $0.textAlignment = .left
        $0.numberOfLines = 1
    }
    
    private let subDateLabel = UILabel().then {
        $0.font = .caption4
        $0.textColor = .gray4
        $0.text = "2024.08.15 ~2024.08.25"
        $0.textAlignment = .left
        $0.numberOfLines = 1
    }
    
    private let goTodayButton = UIButton().then {
        $0.setImage(.goArrow, for: .normal)
        $0.backgroundColor = .magentaPink
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
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
        layer.cornerRadius = 28
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.15
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowRadius = 4
        
        [mainDateLabel, titleLabel, subDateLabel, goTodayButton].forEach {
            addSubview($0)
        }
    
        mainDateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12)
            $0.height.equalTo(40)
            $0.width.equalTo(28)
            $0.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(mainDateLabel.snp.trailing).offset(7)
            $0.trailing.equalTo(goTodayButton.snp.leading).inset(-20)
            $0.top.equalToSuperview().offset(12)
        }
        
        subDateLabel.snp.makeConstraints {
            $0.leading.equalTo(mainDateLabel.snp.trailing).offset(7)
            $0.trailing.equalTo(goTodayButton.snp.leading).inset(20)
            $0.bottom.equalToSuperview().inset(12)
        }
        
        goTodayButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(12)
            $0.width.height.equalTo(40)
            $0.centerY.equalToSuperview()
        }
    }
    
    //MARK: Bind
    override func bind() {
    }
}

extension HomeTodayView {
    func configuration(data: ArtTodayRandom) {
        titleLabel.text = data.title
        subDateLabel.text = "\(data.startDate) ~\(data.endDate)"
    }
}
