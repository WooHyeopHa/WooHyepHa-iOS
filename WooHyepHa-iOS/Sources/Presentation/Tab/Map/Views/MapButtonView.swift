//
//  MapButtonView.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/22/24.
//

import UIKit
import RxSwift
import RxCocoa
import Then
import SnapKit

class MapButtonView: BaseView {

    let selectedGenres = BehaviorSubject<[String]>(value: [])
   
   private let allButton = UIButton().then {
       $0.backgroundColor = .black
       $0.setTitle("전체", for: .normal)
       $0.setTitleColor(.white, for: .normal)
       $0.titleLabel?.font = .body6
       $0.layer.cornerRadius = 18
       $0.contentEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
       $0.addViewShadow(shadowRadius: 5.0, shadowOpacity: 0.1)
   }
   
   private let exhibitionButton = MapButton(title: "전시회", image: .genreExhibition)
   private let concertButton = MapButton(title: "콘서트", image: .genreConcert)
   private let musicalButton = MapButton(title: "뮤지컬/연극", image: .genreMusical)
   private let classicButton = MapButton(title: "클래식/무용", image: .genreClassic)
   
   private var buttons: [MapButton] {
       return [exhibitionButton, concertButton, musicalButton, classicButton]
   }
   
   private var buttonTitles: [String] {
       return ["전시회", "콘서트", "뮤지컬/연극", "클래식/무용"]
   }
   
   private let scrollView = UIScrollView().then {
       $0.backgroundColor = .clear
       $0.showsHorizontalScrollIndicator = false
   }
   
   private let buttonStackView = UIStackView().then {
       $0.axis = .horizontal
       $0.spacing = 6
       $0.distribution = .fillProportionally
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
       backgroundColor = .clear
       [allButton, exhibitionButton, concertButton, musicalButton, classicButton].forEach {
           buttonStackView.addArrangedSubview($0)
       }
       
       scrollView.addSubview(buttonStackView)
       addSubview(scrollView)
   }
   
   override func setConstraints() {
       scrollView.snp.makeConstraints {
           $0.leading.equalToSuperview().inset(20)
           $0.trailing.equalToSuperview()
           $0.verticalEdges.equalToSuperview()
       }
       
       buttonStackView.snp.makeConstraints {
           $0.horizontalEdges.equalTo(scrollView.snp.horizontalEdges)
           $0.height.equalTo(36)
           $0.centerY.equalTo(scrollView)
       }
       
       [allButton, exhibitionButton, concertButton, musicalButton, classicButton].forEach {
           $0.snp.makeConstraints {
               $0.height.equalTo(36)
           }
       }
   }
   
   override func bind() {
       let buttonStates = BehaviorSubject<[Bool]>(value: [false, false, false, false])
       
       allButton.isSelected = true
       allButton.backgroundColor = .black
       allButton.setTitleColor(.white, for: .normal)
       
       selectedGenres.onNext([])
       
       Observable.merge(buttons.enumerated().map { index, button in
           button.rx.tap.map { index }
       })
       .subscribe(with: self, onNext: { owner, tappedIndex in
           guard var currentStates = try? buttonStates.value() else { return }
           
           currentStates[tappedIndex] = !currentStates[tappedIndex]
           buttonStates.onNext(currentStates)
           
           owner.buttons[tappedIndex].isSelected = currentStates[tappedIndex]
           
           let selectedGenres = zip(currentStates, owner.buttonTitles)
               .filter { $0.0 }
               .map { $0.1 }
           owner.selectedGenres.onNext(selectedGenres)
       })
       .disposed(by: disposeBag)
       
       allButton.rx.tap
           .subscribe(with: self, onNext: { owner, _ in
               buttonStates.onNext([false, false, false, false])
               owner.buttons.forEach { $0.isSelected = false }
               
               owner.allButton.isSelected = true
               owner.allButton.backgroundColor = .black
               owner.allButton.setTitleColor(.white, for: .normal)
               
               owner.selectedGenres.onNext([])
           })
           .disposed(by: disposeBag)
       
       buttonStates
           .subscribe(with: self, onNext: { owner, states in
               let anyButtonSelected = states.contains(true)
               
               if anyButtonSelected {
                   owner.allButton.isSelected = false
                   owner.allButton.backgroundColor = .white
                   owner.allButton.setTitleColor(.black, for: .normal)
               } else {
                   owner.allButton.isSelected = true
                   owner.allButton.backgroundColor = .black
                   owner.allButton.setTitleColor(.white, for: .normal)
                   
                   owner.selectedGenres.onNext([])
               }
           })
           .disposed(by: disposeBag)
   }
}
