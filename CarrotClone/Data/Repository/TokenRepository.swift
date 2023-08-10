//
//  TokenRepository.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/07/29.
//

import Foundation
import RxSwift

struct TokenRepository: TokenRepositoryProtocol {
    
    enum TokenError: Error {
        case noToken
        case saveFail
        case deleteFail
        case decode
    }
    
    var keychainManager: KeychainManagerProtocol?
    
    func save(verificationID: String) -> Observable<String> {
        return Observable.create { emitter in
            guard let data = try? JSONEncoder().encode(verificationID) else {
                emitter.onError(TokenError.decode)
                return Disposables.create()
            }
            
            guard keychainManager?.save(key: .verificationID, data: data) ?? false || keychainManager?.update(key: .verificationID, data: data) ?? false else {
                emitter.onError(TokenError.saveFail)
                return Disposables.create()
            }
            
            emitter.onNext(verificationID)
            return Disposables.create()
        }
    }
    
    func save(uid: String) -> Observable<String> {
        return Observable.create { emitter in
            guard let data = try? JSONEncoder().encode(uid) else {
                emitter.onError(TokenError.decode)
                return Disposables.create()
            }
            
            guard keychainManager?.save(key: .uid, data: data) ?? false || keychainManager?.update(key: .uid, data: data) ?? false else {
                emitter.onError(TokenError.saveFail)
                return Disposables.create()
            }
            
            emitter.onNext(uid)
            return Disposables.create()
        }
    }
    
    func loadVerificationID() -> Observable<String> {
        return Observable.create { emitter in
            guard let data = keychainManager?.load(key: .verificationID),
                  let verificationID = try? JSONDecoder().decode(String.self, from: data) else {
                emitter.onError(TokenError.decode)
                return Disposables.create()
            }
            
            emitter.onNext(verificationID)
            return Disposables.create()
        }
    }
    
    func loadUid() -> Observable<String> {
        return Observable.create { emitter in
            guard let data = keychainManager?.load(key: .uid),
                  let uid = try? JSONDecoder().decode(String.self, from: data) else {
                emitter.onError(TokenError.decode)
                return Disposables.create()
            }
            
            emitter.onNext(uid)
            return Disposables.create()
        }
    }
}
