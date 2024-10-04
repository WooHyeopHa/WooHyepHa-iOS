//
//  HomeViewController.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/13/24.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class HomeViewController: BaseViewController {
    
    private var currentIndex: CGFloat = 0
    private var centerCellIndex: Int = 0
    private var isOneStepPaging = true
    private let mokItem: [MokHome] = MokHome.recommendList

    private lazy var blurredBackgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.addBlurEffect()
        return imageView
    }()
    
    private lazy var gradientView: GradientView = {
        let view = GradientView()
        view.setupGradient(colors: [UIColor.clear, UIColor.white],
                           locations: [0.0, 1.0])
        return view
    }()
    
    private let headerView = HomeHeaderView()
    
    private let homeButtonView = HomeButtonView()
    
    private lazy var collectionViewLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 10
    }
    
    private lazy var homeRecommendCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.register(HomeRecommendCollectionViewCell.self, forCellWithReuseIdentifier: HomeRecommendCollectionViewCell.id)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = true
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeRecommendCollectionView.delegate = self
        homeRecommendCollectionView.dataSource = self
        homeRecommendCollectionView.collectionViewLayout.invalidateLayout()
        
        DispatchQueue.main.async {
            self.updateBackgroundImage()
            self.updateCenterCell()
        }
    }
    
    override func setViewController() {
        view.backgroundColor = .white
        [blurredBackgroundImageView, gradientView, headerView, homeButtonView, homeRecommendCollectionView].forEach {
            view.addSubview($0)
        }
    }
    
    override func setConstraints() {
        blurredBackgroundImageView.snp.makeConstraints {
            $0.top.equalTo(view.snp.top)
            $0.height.equalTo(view.snp.height).multipliedBy(0.75)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        gradientView.snp.makeConstraints {
            $0.edges.equalTo(blurredBackgroundImageView)
        }
        
        headerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(56)
        }
        
        homeButtonView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(44)
        }
        
        homeRecommendCollectionView.snp.makeConstraints {
            $0.top.equalTo(homeButtonView.snp.bottom).inset(4.5)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(view.snp.height).multipliedBy(0.6)
        }
    }
}

private extension HomeViewController {
    func updateBackgroundImage() {
        let visibleRect = CGRect(origin: homeRecommendCollectionView.contentOffset, size: homeRecommendCollectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let indexPath = homeRecommendCollectionView.indexPathForItem(at: visiblePoint),
           let cell = homeRecommendCollectionView.cellForItem(at: indexPath) as? HomeRecommendCollectionViewCell {
            UIView.transition(with: blurredBackgroundImageView, duration: 0.3, options: .transitionCrossDissolve) {
                self.blurredBackgroundImageView.image = cell.thumbnailImage
            }
        }
    }
    
    func updateCenterCell() {
        let centerPoint = CGPoint(
            x: homeRecommendCollectionView.contentOffset.x + homeRecommendCollectionView.bounds.width / 2,
            y: homeRecommendCollectionView.bounds.height / 2
        )
        if let indexPath = homeRecommendCollectionView.indexPathForItem(at: centerPoint) {
            if centerCellIndex != indexPath.item {
                centerCellIndex = indexPath.item
                homeRecommendCollectionView.collectionViewLayout.invalidateLayout()
            }
        }
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mokItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeRecommendCollectionViewCell.id, for: indexPath) as? HomeRecommendCollectionViewCell else {
            print("id Error")
            return UICollectionViewCell()
        }
        
        let item = mokItem[indexPath.row]
        cell.configuration(item)
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let isCenter = indexPath.item == centerCellIndex
        let cellWidth = floor(collectionView.frame.width * (isCenter ? 0.80 * 1.05 : 0.80))
        let cellHeight = floor(collectionView.frame.height * (isCenter ? 0.85 * 1.1 : 0.85))
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let cellWidth = floor(collectionView.frame.width * 0.80)
        let insetX = (collectionView.frame.width - cellWidth) / 2.0
        return UIEdgeInsets(top: 0, left: insetX, bottom: 0, right: insetX)
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateBackgroundImage()
        updateCenterCell()
    }
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let layout = self.homeRecommendCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        let normalCellWidth = homeRecommendCollectionView.frame.width * 0.80
        let centerCellWidth = normalCellWidth * 1.05
        let cellWidthIncludingSpacing = normalCellWidth + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        var roundedIndex = round(index)
        
        if scrollView.contentOffset.x > targetContentOffset.pointee.x {
            roundedIndex = floor(index)
        } else if scrollView.contentOffset.x < targetContentOffset.pointee.x {
            roundedIndex = ceil(index)
        } else {
            roundedIndex = round(index)
        }
        
        if isOneStepPaging {
            if currentIndex > roundedIndex {
                currentIndex -= 1
                roundedIndex = currentIndex
            } else if currentIndex < roundedIndex {
                currentIndex += 1
                roundedIndex = currentIndex
            }
        }
        
        let adjustedOffset = roundedIndex * cellWidthIncludingSpacing + (centerCellWidth - normalCellWidth) / 2
        offset = CGPoint(x: adjustedOffset - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
        
        centerCellIndex = Int(roundedIndex)
        homeRecommendCollectionView.collectionViewLayout.invalidateLayout()
    }
}
