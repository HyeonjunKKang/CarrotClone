//
//  UserRepositoryProtocol.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/07/06.
//

import Foundation
import RxSwift

protocol UserRepositoryProtocol {
    func load() -> Observable<User>
    func read(uid: String) -> Observable<User>
    func exits(uid: String) -> Observable<Bool>
    func edit(user: User, imageData: Data) -> Observable<User>
    func edit(user: User) -> Observable<Void>
    func exitsAndCreate() -> Observable<Void>
}
