//
//  CertifyViewModel.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/07/27.
//

import Foundation
import RxSwift
import RxCocoa
import FirebaseAuth

enum CertifyNavigation {
    case back
    case finish
}

final class CertifyViewModel: ViewModel {
    
    struct Input {
        let backButtonTapped: Observable<Void>
        let viewWillAppear: Observable<Void>
        let resendButtonTapped: Observable<Void>
        let certifyAndStartButtonTapped: Observable<Void>
        let AuthenticationNumber: Observable<String>
    }
    
    struct Output {
        let inputPhonenumber: Driver<String>
        let countingResendButtonText: Driver<String>
        let sentMessageAlert: Observable<Void>
    }
    
    var signinUseCase: SignInUseCaseProtocol?
    
    var disposeBag = DisposeBag()
    var countDisposeBag = DisposeBag()
    let navigation = PublishSubject<CertifyNavigation>()
    let inputPhonenumber = BehaviorSubject<String>(value: "")
    let outputPhonenumber = BehaviorSubject<String>(value: "01000000000")
    let countingResendButtonText = BehaviorSubject<String>(value: "인증문자 다시 받기 (00분 00초)")
    let sentMessageAlert = PublishSubject<Void>()
    let timerObservable = Observable<Int>.interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
    let initialTime = 5 * 60
    
    func transform(input: Input) -> Output {
        
        input.backButtonTapped
            .map { .back }
            .bind(to: navigation)
            .disposed(by: disposeBag)
        
        inputPhonenumber
            .take(1)
            .map {
                let pattern = "(\\d{3})(\\d{4})(\\d{4})"
                let regex = try! NSRegularExpression(pattern: pattern, options: [])
                let range = NSRange(location: 0, length: $0.count)
                
                return regex.stringByReplacingMatches(in: $0, range: range, withTemplate: "$1 $2 $3")
            }
            .withUnretained(self)
            .subscribe(onNext: {
                $0.0.outputPhonenumber.onNext($0.1)
            })
            .disposed(by: disposeBag)

        // 인증문자 요청부분
        inputPhonenumber
            .withUnretained(self)
            .flatMap { $0.0.signinUseCase?.requestSingIn(phonenumber: $0.1) ?? .empty() }
            .map { _ in () }
            .bind(to: sentMessageAlert)
            .disposed(by: disposeBag)
            
        // 요청 후 인증번호 인증요청부
        input.certifyAndStartButtonTapped
            .withLatestFrom(input.AuthenticationNumber)
            .withUnretained(self)
            .flatMap { $0.0.signinUseCase?.auchCodeVerificationAndLogin(verificationCode: $0.1) ?? .empty() }
            .map { _ in CertifyNavigation.finish }
            .bind(to: navigation)
            .disposed(by: disposeBag)

        input.resendButtonTapped
            .subscribe(onNext: { [weak self] in
                self?.stopTimer()
                self?.startTimer()
            })
            .disposed(by: disposeBag)
        
        startTimer()
        
        return Output(
            inputPhonenumber: outputPhonenumber.asDriver(onErrorJustReturn: ""),
            countingResendButtonText: countingResendButtonText.asDriver(onErrorJustReturn: "인증문자 다시 받기 (00분 00초)"),
            sentMessageAlert: sentMessageAlert
        )
    }
    
    func startTimer() {
        Observable<Int>.interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .withUnretained(self)
            .map { $0.0.initialTime - $0.1 }
            .take(initialTime + 1)
            .map {
                let minute = $0 / 60
                let remainingSeconds = $0 % 60
                return String(format: "인증문자 다시 받기 (%02d분 %02d초)", minute, remainingSeconds)
            }
            .subscribe(onNext: { [weak self] in
                self?.countingResendButtonText.onNext($0)
            })
            .disposed(by: countDisposeBag)
    }
    
    func stopTimer() {
        countDisposeBag = DisposeBag()
    }
}
