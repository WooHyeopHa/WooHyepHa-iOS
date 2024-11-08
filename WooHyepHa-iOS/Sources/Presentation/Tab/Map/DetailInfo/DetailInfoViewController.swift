//
//  DetailInfoViewController.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 11/1/24.
//

import UIKit

import RxCocoa
import RxSwift
import Then
import SnapKit

class DetailInfoViewController: BaseViewController {
    
    private let viewModel: DetailInfoViewModel
    private let headerView = DetailInfoHeaderView()
    
    private let backgroundThumbnailOverlayView = UIView().then {
        $0.backgroundColor = .black.withAlphaComponent(0.5)
    }
    
    private let backgroundThumbnailImageView = UIImageView()
    
    init(viewModel: DetailInfoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setViewController() {
        view.backgroundColor = .white
        
        [headerView, backgroundThumbnailImageView].forEach {
            view.addSubview($0)
        }
        
        backgroundThumbnailImageView.addSubview(backgroundThumbnailOverlayView)
    }
    
    override func setConstraints() {
        headerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(56)
        }
        
        backgroundThumbnailImageView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(315)
        }
        
        backgroundThumbnailOverlayView.snp.makeConstraints {
            $0.horizontalEdges.equalTo(backgroundThumbnailImageView)
            $0.verticalEdges.equalTo(backgroundThumbnailImageView)
        }
    }
    
    override func bind() {
        let input = DetailInfoViewModel.Input(
            backButtonTapped: headerView.inputBackButton.asObservable()
        )
        
        let output = viewModel.bind(input: input)
        
        output.detailInfoData
            .drive(with: self, onNext: { owner, data in
                print(data)
                owner.headerView.configuration(item: data)
                owner.configuration(item: data)
            })
            .disposed(by: disposeBag)
    }
}

extension DetailInfoViewController {
    func configuration(item: DetailArtData) {
        backgroundThumbnailImageView.setImageKingfisher(with: item.poster.replacingOccurrences(of: "http://", with: "https://"))
    }
}
