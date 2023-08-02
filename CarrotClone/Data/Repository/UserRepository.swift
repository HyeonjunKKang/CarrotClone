//
//  UserRepository.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/07/06.
//

import Foundation
import RxSwift

struct UserRepository: UserRepositoryProtocol {
    
    enum UserRepositoryError: Error {
        case noUserInfo
    }
    
    var userDataSource: UserDataSourceProtocol?
    var keyChainManager: KeychainManagerProtocol?
    
    func load() -> Observable<User> {
        guard let data = keyChainManager?.load(key: .uid),
              let uid = String(data: data, encoding: .utf8) else {
            return Observable.error(UserRepositoryError.noUserInfo) }
        
        return read(uid: uid)
    }
    
    func read(uid: String) -> Observable<User> {
        return (userDataSource?.read(uid: uid) ?? .empty())
            .map { $0.toDomain() }
    }
    
    func exits(uid: String) -> Observable<Bool> {
        return userDataSource?.exitsUserData(uid: uid) ?? .empty()
    }
    
    func edit(user: User, imageData: Data) -> Observable<User> {
    
        return (userDataSource?.uploadProfileImage(id: user.uid, imageData: imageData) ?? .empty())
            .map { $0.absoluteString }
            .map {
                UserRequestDTO(
                    uid: user.uid,
                    profileImageURLString: $0,
                    email: user.email,
                    name: user.name
                )
            }
            .flatMap { userDataSource?.edit(request: $0) ?? .empty()}
            .map { $0.toDomain() }
    }
    
    func edit(user: User) -> Observable<Void> {
        let request = UserRequestDTO(
            uid: user.uid,
            profileImageURLString: user.profileImageURLString,
            email: user.email,
            name: user.name
        )
        return (userDataSource?.edit(request: request) ?? .empty())
            .map { _ in () }
    }
    
    func exitsAndCreate() -> Observable<Void> {
        var uid = " "
        
        if let uidData = keyChainManager?.load(key: .uid),
           let uidString = String(data: uidData, encoding: .utf8.self) {
            uid = uidString
        }
        
        return exits(uid: uid)
            .flatMap {
                if $0 {
                    return Observable.just(())
                } else {
                    let user = User(uid: uid, profileImageURLString: "", email: "", name: "")
                    
                    return edit(user: user)
                }
            }
    }
}
