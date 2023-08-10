//
//  AutoLoginUseCase.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/08/08.
//

import Foundation
import RxSwift

struct AutoLoginUseCase: AutoLoginUseCaseProtocol {
    
    var tokenRepository: TokenRepositoryProtocol?
    
    func load() -> Observable<String> {
        return tokenRepository?.loadUid() ?? .empty()
    }
}
