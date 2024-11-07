//
//  ArtRepositoryProtocol.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 11/7/24.
//

import RxSwift
import CoreLocation

protocol ArtRepositoryProtocol {
    func fetchDetailArtInfo(artId: Int) -> Observable<DetailArt>
}

