//
//  TokenRepositoryProtocol.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/07/29.
//

import RxSwift

protocol TokenRepositoryProtocol {
    func save(verificationID: String) -> Observable<String>
    func save(uid: String) -> Observable<String>
    func loadVerificationID() -> Observable<String>
    func loadUid() -> Observable<String>
}
