//
//  CultureCalendarViewController.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/9/24.
//

import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa

class CultureCalendarViewController: BaseViewController {
    
    private let viewModel: CultureCalendarViewModel
    
    private let headerView = CultureCalendarHeaderView()
    private let cultureCalendarDateButtonView = CultureCalendarDateButtonView()
    private let cultureCalendarButtonView = CultureCalendarButtonView()

    private var testData: [ArtList] = []
    
    private let cultureCountLabel = UILabel().then {
        $0.text = "0개 문화예술"
        $0.font = .body3
        $0.textColor = .gray1
        $0.textAlignment = .left
    }
    
    private let sortButton = UIButton().then {
        $0.setTitle("최신순", for: .normal)
        $0.setImage(.downarrow, for: .normal)
        $0.setTitleColor(.gray4, for:  .normal)
        $0.titleLabel?.textAlignment = .right
        $0.titleLabel?.font = .body4
        $0.semanticContentAttribute = .forceRightToLeft
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 0)
    }
    
    private lazy var collectionViewLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
        $0.minimumLineSpacing = 10
    }
    
    private lazy var cultureCalendarCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.register(CultureCalendarCollectionViewCell.self, forCellWithReuseIdentifier: CultureCalendarCollectionViewCell.id)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = true
        return collectionView
    }()
    
    init(viewModel: CultureCalendarViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cultureCalendarCollectionView.delegate = self
        cultureCalendarCollectionView.dataSource = self
    }
    
    override func setViewController() {
        view.backgroundColor = .white
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        [headerView, cultureCalendarDateButtonView, cultureCalendarButtonView, cultureCountLabel, sortButton, cultureCalendarCollectionView].forEach {
            view.addSubview($0)
        }
    }
    
    override func setConstraints() {
        headerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(56)
        }
        
        cultureCalendarDateButtonView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(52)
        }
        
        cultureCalendarButtonView.snp.makeConstraints {
            $0.top.equalTo(cultureCalendarDateButtonView.snp.bottom)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(64)
        }
        
        cultureCountLabel.snp.makeConstraints {
            $0.top.equalTo(cultureCalendarButtonView.snp.bottom).offset(16)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        sortButton.snp.makeConstraints {
            $0.top.equalTo(cultureCalendarButtonView.snp.bottom).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        cultureCalendarCollectionView.snp.makeConstraints {
            $0.top.equalTo(cultureCountLabel.snp.bottom).offset(24)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    override func bind() {
        sortButton.rx.tap
            .subscribe(with: self, onNext: { owner, _ in
                let modal = CultureCalendarSortModalViewController()
                modal.showModal(vc: self)
            })
            .disposed(by: disposeBag)
        
        let input = CultureCalendarViewModel.Input(
            nowButtonTapped: headerView.inputNowButton.asObservable()
        )
        
        let output = viewModel.bind(input: input)
        
        output.mockCultureCalendarData
            .drive(with: self, onNext: { owner, data in
                owner.testData = data.data.artList
                owner.cultureCountLabel.text = "\(data.data.artList.count)개 문화예술"
            })
            .disposed(by: disposeBag)
    }
}

extension CultureCalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 144)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(20)
    }
}


extension CultureCalendarViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        testData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CultureCalendarCollectionViewCell.id, for: indexPath) as? CultureCalendarCollectionViewCell else {
            print("id Error")
            return UICollectionViewCell()
        }
        
        let item = testData[indexPath.row]
        cell.configuration(item)
        return cell
    }
}

