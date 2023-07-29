//
//  SignInUseCaseProtocol.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/07/29.
//

import RxSwift

protocol SignInUseCaseProtocol {
    func requestSingIn(phonenumber: String) -> Observable<String>
    func auchCodeVerificationAndLogin(verificationCode: String) -> Observable<String> 
}
