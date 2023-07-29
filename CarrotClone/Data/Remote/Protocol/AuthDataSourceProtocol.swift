//
//  AuthDataSourceProtocol.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/07/27.
//

import Foundation
import RxSwift

protocol AuthDataSourceProtocol {
    func phoneNumberAuthenticationRequest(phoneNumber: String) -> Observable<String>
    func authCodeVerificationRequest(verificationCode: String, verificationID: String) -> Observable<String>
}
