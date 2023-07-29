//
//  SignInUseCase.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/07/27.
//

import Foundation
import RxSwift

enum SignInResult {
    
}

struct SignInUseCase: SignInUseCaseProtocol {
    
    var authRepository: AuthRepositoryProtocol?
    var tokenRepository: TokenRepositoryProtocol?
    
    /// 인증 요청을 보내고 문자를 요청한 후 verificationID를 키체인에 저장
    func requestSingIn(phonenumber: String) -> Observable<String> {
        return (authRepository?.phoneNumberAuthenticationRequest(phonenumber: phonenumber) ?? .empty())
            .flatMap { tokenRepository?.save(verificationID: $0) ?? .empty() }
    }
    
    func auchCodeVerificationAndLogin(verificationCode: String) -> Observable<String> {
        return (tokenRepository?.loadVerificationID() ?? .empty())
            .flatMap { authRepository?.authCodeVerificationRequest(verificationCode: verificationCode, verificationID: $0) ?? .empty() }
            
    }
}
