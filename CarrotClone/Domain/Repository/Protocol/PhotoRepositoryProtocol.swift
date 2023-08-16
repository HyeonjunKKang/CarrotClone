//
//  PhotoRepositoryProtocol.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/08/10.
//

import RxSwift

protocol PhotoRepositoryProtocol {
    func fetchPHAsset() -> Observable<[Photo]>
}