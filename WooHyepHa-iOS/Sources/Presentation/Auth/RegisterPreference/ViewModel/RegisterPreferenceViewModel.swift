//
//  RegisterPreferenceViewModel.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 9/30/24.
//

import RxSwift
import RxCocoa

final class RegisterPreferenceViewModel: ViewModelType {
    struct Input {
        let disableButtonTapped: Observable<Void>
        let backButtonTapped: Observable<Void>
        
        let preferenceExhibitionButtonTapped: Observable<String>
        let preferenceConcertButtonTapped: Observable<String>
        let preferenceMusicalButtonTapped: Observable<String>
        let preferenceClassicButtonTapped: Observable<String>
    }
    
    struct Output {
        let isDisableButtonEnabled: Driver<Bool>
    }
    
    let disposeBag = DisposeBag()
    weak var coordinator: AuthCoordinator?
    
    init(coordinator: AuthCoordinator) {
        self.coordinator = coordinator
    }
    
    func bind(input: Input) -> Output {
        var selectedAllPreference: [String] = []
        
        var selectedPreferenceExhibition: [String] = []
        var selectedPreferenceConcert: [String] = []
        var selectedPreferenceMusical: [String] = []
        var selectedPreferenceClassic: [String] = []

        let isValid = BehaviorSubject<Bool>(value: false)

        Observable.merge(input.preferenceExhibitionButtonTapped, input.preferenceConcertButtonTapped, input.preferenceMusicalButtonTapped, input.preferenceClassicButtonTapped)
            .subscribe(onNext: { field in
                if let index = selectedAllPreference.firstIndex(of: field) {
                    selectedAllPreference.remove(at: index)
                } else {
                    selectedAllPreference.append(field)
                }
            isValid.onNext(!selectedAllPreference.isEmpty)
            })
            .disposed(by: disposeBag)
        
        input.preferenceExhibitionButtonTapped
            .subscribe(with: self, onNext: { owner, exhibition in
                if let index = selectedPreferenceExhibition.firstIndex(of: exhibition) {
                    selectedPreferenceExhibition.remove(at: index)
                } else {
                    selectedPreferenceExhibition.append(exhibition)
                }
                print(selectedPreferenceExhibition)
                // 나중에 서버에 post 하는 로직 구현
            })
            .disposed(by: disposeBag)        
        
        input.preferenceConcertButtonTapped
            .subscribe(with: self, onNext: { owner, concert in
                if let index = selectedPreferenceConcert.firstIndex(of: concert) {
                    selectedPreferenceConcert.remove(at: index)
                } else {
                    selectedPreferenceConcert.append(concert)
                }
                print(selectedPreferenceConcert)
                // 나중에 서버에 post 하는 로직 구현
            })
            .disposed(by: disposeBag)        
        
        input.preferenceMusicalButtonTapped
            .subscribe(with: self, onNext: { owner, musical in
                if let index = selectedPreferenceMusical.firstIndex(of: musical) {
                    selectedPreferenceMusical.remove(at: index)
                } else {
                    selectedPreferenceMusical.append(musical)
                }
                print(selectedPreferenceMusical)
                // 나중에 서버에 post 하는 로직 구현
            })
            .disposed(by: disposeBag)        
        
        input.preferenceClassicButtonTapped
            .subscribe(with: self, onNext: { owner, classic in
                if let index = selectedPreferenceClassic.firstIndex(of: classic) {
                    selectedPreferenceClassic.remove(at: index)
                } else {
                    selectedPreferenceClassic.append(classic)
                }
                print(selectedPreferenceClassic)
                // 나중에 서버에 post 하는 로직 구현
            })
            .disposed(by: disposeBag)
        
        input.backButtonTapped
            .subscribe(with: self, onNext: { owner, _ in
                owner.coordinator?.pop()
            })
            .disposed(by: disposeBag)
        
        input.disableButtonTapped
            .subscribe(with: self, onNext: { owner, _ in
                print("가입")
                // 나중에 Home으로 이동하는 코디네이터 로직 추가
            })
            .disposed(by: disposeBag)
        
        return Output(
            isDisableButtonEnabled: isValid.asDriver(onErrorDriveWith: .empty())
        )
    }
}
