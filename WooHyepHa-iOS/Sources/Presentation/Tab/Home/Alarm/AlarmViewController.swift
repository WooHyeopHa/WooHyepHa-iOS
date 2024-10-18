//
//  AlarmViewController.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/18/24.
//

import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa

class AlarmViewController: BaseViewController {
    
    private let viewModel: AlarmViewModel
    
    private let headerView = AlarmHeaderView()
    private let alarmButtonView = AlarmButtonView()
    
    init(viewModel: AlarmViewModel) {
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
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        [headerView, alarmButtonView].forEach {
            view.addSubview($0)
        }
    }
    
    override func setConstraints() {
        headerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(56)
        }        
        
        alarmButtonView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(52)
        }
    }
    
    override func bind() {
        let input = AlarmViewModel.Input(
            backButtonTapped: headerView.inputBackButton.asObservable()
        )
        
        let _ = viewModel.bind(input: input)
    }
}
