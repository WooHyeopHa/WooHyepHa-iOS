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
    
    private let headerView = MapHeaderView()
    private let mapButtonView = MapButtonView()
    
    private var currentUserLocation: CLLocationCoordinate2D?
    private let infoButtonTapped = PublishRelay<Int>()
    
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
        
        [naverMapView, headerView, mapButtonView].forEach {
            view.addSubview($0)
        }
    }
    
    override func setConstraints() {
        headerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(60)
        }        
        
        mapButtonView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(36)
        }
    }
    
    override  func bind() {
        mapButtonView.selectedGenres
            .subscribe(onNext: { genres in
                if genres.isEmpty {
                    print("전체")
                } else {
                    print("선택 장르 : \(genres)")
                }
            })
            .disposed(by: disposeBag)
        
                let input = MapViewModel.Input(
                    infoButtonTapped: infoButtonTapped.asObservable()
                )
        
        let output = viewModel.bind(input: input)
        
        output.currentStatus
            .drive(with: self, onNext: { owner, status in
                print(status)
            })
            .disposed(by: disposeBag)
        
        output.currentLocation
            .drive(with: self, onNext: { owner, location in
                owner.currentUserLocation = location
                owner.addOrUpdateRangeCircle(location: location)
                owner.setLocationOverlay(location: location)
            })
            .disposed(by: disposeBag)
        
        output.artMapListData
            .drive(with: self, onNext: { owner, item in
                owner.addCultureMarkersToMap(items: item.data.artMapList)
            })
            .disposed(by: disposeBag)
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
        locationOverlay.icon = NMFOverlayImage(image: .mapUserMarker)
        locationOverlay.iconWidth = CGFloat(20)
        locationOverlay.iconHeight = CGFloat(20)
        moveCamera(location: location)
    }
    
    func addOrUpdateRangeCircle(location: CLLocationCoordinate2D) {
        let circle = NMFCircleOverlay()
        let coord = NMGLatLng(lat: location.latitude, lng: location.longitude)
        circle.center = coord
        circle.radius = 80
        circle.fillColor = UIColor.MainColor.withAlphaComponent(0.2)
        circle.outlineWidth = 0
        circle.mapView = naverMapView
    }
    
    func addCultureMarkersToMap(items: [ArtMapList]) {
        for item in items {
            guard let latitude = Double(item.latitude),
                  let longitude = Double(item.longitude) else {
                continue
            }
            
            let marker = CultureMarker()
            marker.position = NMGLatLng(lat: latitude, lng: longitude)
            marker.mapView = naverMapView
            marker.touchHandler = { [weak self] overlay -> Bool in
                self?.handleMarkerTap(marker: overlay as! CultureMarker, item: item)
                return true
            }
        }
    }
    
    func handleMarkerTap(marker: CultureMarker, item: ArtMapList) {
        // 이미 선택된 마커를 다시 탭했을 경우
        if marker === selectedMarker {
            // 마커 이미지를 원래대로 복구
            marker.iconImage = NMFOverlayImage(image: .mapMarker)
            selectedMarker = nil
            
            // 커스텀 뷰 제거
            customView?.removeFromSuperview()
            customView = nil
            return
        }
        
        // 새로운 마커를 탭했을 경우
        selectedMarker?.iconImage = NMFOverlayImage(image: .mapMarker)
        marker.iconImage = NMFOverlayImage(image: .mapMarkerActive)
        selectedMarker = marker
        
        showCustomView(for: item)
    }
    
    func showCustomView(for item: ArtMapList) {
        customView?.removeFromSuperview()

        let newCustomView = MapCustomView()
        
        // 저장된 현재 위치 사용
        if let currentLocation = currentUserLocation {
            newCustomView.configure(item: item, currentLocation: currentLocation)
        } else {
            // 위치를 가져올 수 없는 경우 기본 설정 또는 에러 처리
            print("현재 위치를 가져올 수 없습니다.")
            newCustomView.configure(item: item, currentLocation: CLLocationCoordinate2D(latitude: 37.5666791, longitude: 126.9782914))  // 서울시청 좌표로 기본값 설정
        }
        
        view.addSubview(newCustomView)

        newCustomView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(158)
        }

        newCustomView.inputInfoButton
            .map { newCustomView.inputCurrentItem ?? 0 }
            .bind(to: infoButtonTapped)
            .disposed(by: disposeBag)
        
        customView = newCustomView
    }
}
