import UIKit

import Then
import SnapKit
import RxCocoa
import RxSwift

class PreferenceCultureView: BaseView {

    private let exhibitionButton = PreferenceCultureButton(title: "전시회")
    private let concertButton = PreferenceCultureButton(title: "콘서트")
    private let musicalButton = PreferenceCultureButton(title: "뮤지컬/연극")
    private let filmFestivalButton = PreferenceCultureButton(title: "영화제")
    
    private let horizontalStackView1 = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 10
    }
    
    private let horizontalStackView2 = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 10
    }
    
    private let verticalStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 10
    }

    private var selectedCultures: Set<String> = []

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setView() {
        showTopBorder = false
        showBottomBorder = false
        
        [exhibitionButton, concertButton].forEach {
            horizontalStackView1.addArrangedSubview($0)
        }
        
        [musicalButton, filmFestivalButton].forEach {
            horizontalStackView2.addArrangedSubview($0)
        }
        
        [horizontalStackView1, horizontalStackView2].forEach {
            verticalStackView.addArrangedSubview($0)
        }
        addSubview(verticalStackView)
    }
    
    override func setConstraints() {
        verticalStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(verticalStackView.snp.width)
        }
    }
    
    override func bind() {
        inputPreferenceCulture
            .subscribe(with: self, onNext: { owner, type in
                owner.toggleButton(type)
            })
            .disposed(by: disposeBag)
    }
}

extension PreferenceCultureView {
    enum PreferenceCultureButtonType: String {
        case exhibition = "exhibition"
        case concert = "concert"
        case musical = "musical"
        case filmFestival = "filmFestival"
    }
    
    var inputPreferenceCulture: Observable<String> {
        return Observable.merge(
            exhibitionButton.rx.tap.map { PreferenceCultureButtonType.exhibition.rawValue },
            concertButton.rx.tap.map { PreferenceCultureButtonType.concert.rawValue },
            musicalButton.rx.tap.map { PreferenceCultureButtonType.musical.rawValue },
            filmFestivalButton.rx.tap.map { PreferenceCultureButtonType.filmFestival.rawValue }
        )
    }
}

extension PreferenceCultureView {
    private func toggleButton(_ field: String) {
        if let buttonType = PreferenceCultureButtonType(rawValue: field) {
            let button: PreferenceCultureButton
            switch buttonType {
            case .exhibition:
                button = exhibitionButton
            case .concert:
                button = concertButton
            case .musical:
                button = musicalButton
            case .filmFestival:
                button = filmFestivalButton
            }
            
            button.isSelected.toggle()
            
            if button.isSelected {
                selectedCultures.insert(field)
            } else {
                selectedCultures.remove(field)
            }
        }
    }
}
