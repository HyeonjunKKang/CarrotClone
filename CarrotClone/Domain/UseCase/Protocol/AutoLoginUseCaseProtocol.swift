//
//  AutoLoginUseCaseProtocol.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/08/08.
//

import RxSwift

protocol AutoLoginUseCaseProtocol {
    func load() -> Observable<String> 
}
