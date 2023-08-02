//
//  SignInUseCase.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/07/27.
//

import Foundation
import RxSwift

struct SignInUseCase: SignInUseCaseProtocol {
    
    var authRepository: AuthRepositoryProtocol?
    var tokenRepository: TokenRepositoryProtocol?
    var userRepository: UserRepositoryProtocol?
    
    /// 인증 요청을 보내고 문자를 요청한 후 verificationID를 키체인에 저장
    func requestSingIn(phonenumber: String) -> Observable<String> {
        return (authRepository?.phoneNumberAuthenticationRequest(phonenumber: phonenumber) ?? .empty())
            .flatMap { tokenRepository?.save(verificationID: $0) ?? .empty() }
    }
    
    // MARK: - Login하고 데이터가 없다면 데이터베이스 생성하는 로직 설계해야함
    func auchCodeVerificationAndLogin(verificationCode: String) -> Observable<Void> {
        return ( tokenRepository?.loadVerificationID() ?? .empty() )
            .flatMap { authRepository?.authCodeVerificationRequest(verificationCode: verificationCode, verificationID: $0) ?? .empty() }
            .flatMap { tokenRepository?.save(uid: $0) ?? .empty() }
            .flatMap { _ in userRepository?.exitsAndCreate() ?? .empty() }
    }
}
