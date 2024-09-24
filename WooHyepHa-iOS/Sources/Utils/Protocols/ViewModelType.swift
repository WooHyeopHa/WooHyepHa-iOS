//
//  ViewModelType.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/26/24.

import RxSwift

protocol ViewModelType: AnyObject {
    associatedtype Input
    associatedtype Output
    
    var disposeBag: DisposeBag { get }
    
    func bind(input: Input) -> Output
}
