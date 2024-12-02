//
//  DetailInfoViewModel.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 11/7/24.
//

import RxSwift
import RxCocoa

final class DetailInfoViewModel: ViewModelType {
    struct Input {
        let backButtonTapped: Observable<Void>
    }
    
    struct Output {
        let detailInfoData: Driver<DetailArtData>
        //let detailInfoData: Driver<DetailArt>
    }
    
    let disposeBag = DisposeBag()
    weak var coordinator: MapCoordinator?
    private let artUseCase: ArtUseCase
    private let artId: Int
    private let uid: Int
    
    init(coordinator: MapCoordinator, artUseCase: ArtUseCase, artId: Int, uid: Int) {
        self.artUseCase = artUseCase
        self.coordinator = coordinator
        self.artId = artId
        self.uid = uid
    }
    
    func bind(input: Input) -> Output {
        print(artId)
        print(uid)
        let detailInfoData = BehaviorRelay<DetailArtData>(value: DetailArtData(poster: "", title: "", genre: "", age: "", place: "", startDate: "", endDate: "", startTime: "", park: "", detailPhoto: "", startScore: 0.0, reviewCnt: 0, spark: ""))

        input.backButtonTapped
            .subscribe(with: self, onNext: { owner, _ in
                owner.coordinator?.pop(animated: false)
            })
            .disposed(by: disposeBag)
        
        artUseCase.fetchDetailArtInfo(artId: artId, uid: uid)
            .subscribe(with: self, onNext: { owner, data in
                detailInfoData.accept(data.data)
            })
            .disposed(by: disposeBag)
        
        return Output (
            detailInfoData: detailInfoData.asDriver()
        )
    }
}
