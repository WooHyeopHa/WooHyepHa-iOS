//
//  MapCustomView.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/18/24.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

import CoreLocation

class MapCustomView: BaseView {
    
//    private let thumbnail = UIImageView().then {
//        $0.image = UIImage(named: "maniac")
//        $0.clipsToBounds = true
//        $0.layer.cornerRadius = 5
//    }    
    
    private var currentItem: ArtMapList?
    
    private let thumbnail = UIButton().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 5
    }
    
    private let category = PaddingLabel().then {
        $0.font = .caption2
        $0.textColor = .gray2
        $0.backgroundColor = .gray9
        $0.layer.cornerRadius = 11
        $0.clipsToBounds = true
        $0.textAlignment = .center
        $0.numberOfLines = 1
        $0.textInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    
    private let title = UILabel().then {
        $0.font = .sub5
        $0.numberOfLines = 2
        $0.textColor = .gray1
    }
    
    private let date = UILabel().then {
        $0.font = .body6
        $0.textColor = .gray5
    }
    
    private let cultureDistance = UILabel().then {
        $0.font = .body4
        $0.textColor = .MainColor
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        $0.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    }
    
    private let state = UILabel().then {
        $0.font = .body6
        $0.textColor = .gray1
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
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        
        [thumbnail, category, title, cultureDistance, state, date].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraints() {
        thumbnail.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(20)
            $0.width.equalTo(90)
            $0.leading.equalToSuperview().offset(12)
        }
        
        category.snp.makeConstraints {
            $0.leading.equalTo(thumbnail.snp.trailing).offset(10)
            $0.top.equalToSuperview().offset(20)
            $0.height.equalTo(22)
        }
        
        title.snp.makeConstraints {
            $0.leading.equalTo(thumbnail.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().inset(12)
            $0.top.equalTo(category.snp.bottom).offset(4)
        }
        
        cultureDistance.snp.makeConstraints {
            $0.leading.equalTo(thumbnail.snp.trailing).offset(10)
            $0.top.equalTo(title.snp.bottom).offset(4)
        }
        
        state.snp.makeConstraints {
            $0.leading.equalTo(cultureDistance.snp.trailing).offset(5)
            $0.trailing.equalToSuperview().inset(12)
            $0.top.equalTo(title.snp.bottom).offset(4)
        }
        
        date.snp.makeConstraints {
            $0.leading.equalTo(thumbnail.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().inset(12)
            $0.top.equalTo(state.snp.bottom).offset(4)
        }
    }

    func configure(item: ArtMapList, currentLocation: CLLocationCoordinate2D) {
        currentItem = item
        
        thumbnail.setImage(UIImage(named: item.poster), for: .normal)
        title.text = item.title
        category.text = item.genre
        date.text = "\(item.startDate) ~ \(item.endDate)"
        state.text = item.place

        let distance = calculateDistance(
            itemLat: item.latitude,
            itemLong: item.longitude,
            currentLat: currentLocation.latitude,
            currentLong: currentLocation.longitude
        )
        
        let formattedDistance = formatDistance(distance)
        cultureDistance.text = formattedDistance
    }
}

extension MapCustomView {
    var inputInfoButton: Observable<Void> {
        thumbnail.rx.tap
            .asObservable()
    }
    
    var inputCurrentItem: Int? {
        currentItem?.artId
    }
}

private extension MapCustomView {
    func calculateDistance(itemLat: String, itemLong: String, currentLat: Double, currentLong: Double) -> Int {
        guard let itemLatitude = Double(itemLat),
              let itemLongitude = Double(itemLong) else {
            return 0
        }
        
        let itemLocation = CLLocation(latitude: itemLatitude, longitude: itemLongitude)
        let currentLocation = CLLocation(latitude: currentLat, longitude: currentLong)
        
        let distanceInMeters = itemLocation.distance(from: currentLocation)
        return Int(distanceInMeters)
    }
    
    private func formatDistance(_ meters: Int) -> String {
        if meters >= 1000 {
            let kilometers = Double(meters) / 1000.0
            return String(format: "%.1fkm", kilometers)
        } else {
            return "\(meters)m"
        }
    }
}
