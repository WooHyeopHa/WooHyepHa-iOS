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
    
    private let artId: Int
    private let headerView = DetailInfoHeaderView()
    
    init(artId: Int) {
        self.artId = artId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        print(artId)
        super.viewDidLoad()
    }
    
    override func setViewController() {
        view.backgroundColor = .white
        
        [headerView].forEach {
            view.addSubview($0)
        }
    }
    
    override func setConstraints() {
        headerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(56)
        }
    }
}
