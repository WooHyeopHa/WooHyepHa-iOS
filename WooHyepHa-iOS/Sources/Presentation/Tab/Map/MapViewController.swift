//
//  MapViewController.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/13/24.
//

import UIKit

import CoreLocation
import RxCocoa
import RxSwift
import Then
import SnapKit
import NMapsMap

class MapViewController: BaseViewController {
    
    private var customView: MapCustomView?
    private var selectedMarker: CultureMarker?
    
    private let viewModel: MapViewModel
    private let locationManager = NMFLocationManager.sharedInstance()
    private let coreLocationManager = CLLocationManager()
    
    private lazy var naverMapView = NMFMapView(frame: self.view.frame).then {
        $0.isNightModeEnabled = false
        $0.extent = NMGLatLngBounds(
            southWestLat: 33,
            southWestLng: 123,
            northEastLat: 42,
            northEastLng: 133
        )
        $0.minZoomLevel = 5
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(viewModel: MapViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setViewController() {
        view.backgroundColor = .white
        
        [naverMapView].forEach {
            view.addSubview($0)
        }
    }
    
    override  func bind() {
        let input = MapViewModel.Input()
        
        let output = viewModel.bind(input: input)
        
        output.currentStatus
            .drive(with: self, onNext: { owner, status in
                print(status)
            })
            .disposed(by: disposeBag)
        
        output.currentLocation
            .drive(with: self, onNext: { owner, location in
                owner.addOrUpdateRangeCircle(location: location)
                owner.setLocationOverlay(location: location)
            })
            .disposed(by: disposeBag)
        
//        output.cultureItem
//            .drive(with: self, onNext: { owner, item in
//                owner.addCultureMarkersToMap(items: item)
//            })
//            .disposed(by: disposeBag)
    }
}

private extension MapViewController {
    func moveCamera(location: CLLocationCoordinate2D) {
        let coord = NMGLatLng(lat: location.latitude, lng: location.longitude)
        let cameraUpdate = NMFCameraUpdate(scrollTo: coord)
        cameraUpdate.animation = .easeIn
        naverMapView.moveCamera(cameraUpdate)
    }
    
    func setLocationOverlay(location: CLLocationCoordinate2D) {
        let coord = NMGLatLng(lat: location.latitude, lng: location.longitude)
        let locationOverlay = naverMapView.locationOverlay
        locationOverlay.hidden = false
        locationOverlay.location = coord
        locationOverlay.icon = NMFOverlayImage(image: UIImage(named: "userMarker")!)
        locationOverlay.iconWidth = CGFloat(20)
        locationOverlay.iconHeight = CGFloat(20)
        moveCamera(location: location)
    }
    
    func addOrUpdateRangeCircle(location: CLLocationCoordinate2D) {
        let circle = NMFCircleOverlay()
        let coord = NMGLatLng(lat: location.latitude, lng: location.longitude)
        circle.center = coord
        circle.radius = 80
        circle.fillColor = UIColor.orange.withAlphaComponent(0.3)
        circle.outlineWidth = 0
        circle.mapView = naverMapView
    }
    
//    func addCultureMarkersToMap(items: [Map]) {
//        for item in items {
//            guard let latitude = Double(item.latitude),
//                  let longitude = Double(item.longitude) else {
//                continue
//            }
//            
//            let marker = CultureMarker()
//            marker.position = NMGLatLng(lat: latitude, lng: longitude)
//            marker.mapView = naverMapView
//            marker.touchHandler = { [weak self] overlay -> Bool in
//                self?.handleMarkerTap(marker: overlay as! CultureMarker, item: item)
//                return true
//            }
//        }
//    }
    
//    func handleMarkerTap(marker: CultureMarker, item: Map) {
//        // 이전에 선택된 마커가 있다면 원래 이미지로 복구
//        selectedMarker?.iconImage = NMFOverlayImage(name: "itemMarker")
//        
//        // 새로 선택된 마커의 이미지 변경
//        marker.iconImage = NMFOverlayImage(name: "DetailMarker")
//        selectedMarker = marker
//        
//       showCustomView(for: item)
//    }
//    
//    func showCustomView(for item: Map) {
//        // 기존 커스텀 뷰가 있다면 제거
//        customView?.removeFromSuperview()
//
//        // 새 커스텀 뷰 생성 및 설정
//        let newCustomView = CustomView()
//        newCustomView.configure(item: item)
//        view.addSubview(newCustomView)
//
//        newCustomView.snp.makeConstraints { make in
//            make.left.right.equalToSuperview().inset(16)
//            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
//            make.height.equalTo(168) // 적절한 높이로 조정
//        }
//
//        customView = newCustomView
//    }
}
