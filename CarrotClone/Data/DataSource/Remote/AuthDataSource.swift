//
//  AuthDataSource.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/07/27.
//

import Foundation
import RxSwift
import FirebaseAuth


struct AuthDataSource: AuthDataSourceProtocol {
    
    /// 인증번호 전송 요청(휴대전화 로그인)
    func phoneNumberAuthenticationRequest(phoneNumber: String) -> Observable<String> {
        return Observable.create { emitter in
            
            PhoneAuthProvider.provider().verifyPhoneNumber("+82\(phoneNumber)", uiDelegate: nil) { verificationID, error in
                if let verificationID = verificationID {
                    
                    print("DEBUG: response of phonenumber auth request is verificationID = \(verificationID)")
                    
                    emitter.onNext(verificationID)
                }
                
                if let error = error {
                    print("DEBUG: response of phonenumber auth request Error is = \(error)")
                    
                    emitter.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
    
    /// 인증번호 확인 요청(휴대전화 로그인), uid 리턴
    func authCodeVerificationRequest(verificationCode: String, verificationID: String) -> Observable<String> {
        return Observable<String>.create { emitter in
            
            let credential = PhoneAuthProvider.provider()
                .credential(withVerificationID: verificationID, verificationCode: verificationCode)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("DEBUG: \(error.localizedDescription)")
                    print("LogIn Failed...")
                } else {
                    print("DEBUG: Login Success!! UID IS \(String(describing: authResult?.user.uid))")
                    
                    guard let uid = authResult?.user.uid else { return }
                    emitter.onNext(uid)
                }
            }
            return Disposables.create()
        }
    }
}
