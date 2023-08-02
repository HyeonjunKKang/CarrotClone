//
//  AuthRepository.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/07/27.
//

import Foundation
import RxSwift

struct AuthRepository: AuthRepositoryProtocol{
    
    var authDataSource: AuthDataSourceProtocol?
    
    func phoneNumberAuthenticationRequest(phonenumber: String) -> Observable<String> {
        return authDataSource?.phoneNumberAuthenticationRequest(phoneNumber: phonenumber) ?? .empty()
    }
    
    /// 인증번호 확인 요청(휴대전화 로그인), uid 리턴
    func authCodeVerificationRequest(verificationCode: String, verificationID: String) -> Observable<String> {
        return authDataSource?.authCodeVerificationRequest(verificationCode: verificationCode, verificationID: verificationID) ?? .empty()
            
    }
}
