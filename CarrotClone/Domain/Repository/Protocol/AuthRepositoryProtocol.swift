//
//  AuthRepositoryProtocol.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/07/27.
//

import RxSwift

protocol AuthRepositoryProtocol
{
    func phoneNumberAuthenticationRequest(phonenumber: String) -> Observable<String>
    func authCodeVerificationRequest(verificationCode: String, verificationID: String) -> Observable<String>
}
