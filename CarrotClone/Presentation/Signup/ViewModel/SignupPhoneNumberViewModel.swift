//
//  SignupPhoneNumberViewModel.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/07/15.
//

import Foundation
import RxSwift

enum SignupPhoneNumberResult {
    case back
    case send(String)
}

final class SignupPhoneNumberViewModel: ViewModel {
    struct Input {
        let backButtonTapped: Observable<Void>
        let sendAuthButtonTapped: Observable<Void>
        let inputPhoneNumber: Observable<String?>
    }
    
    struct Output {
        
    }
    
    var disposeBag = DisposeBag()
    let navigation = PublishSubject<SignupPhoneNumberResult>()
    
    func transform(input: Input) -> Output {
        input.backButtonTapped
            .map { .back }
            .bind(to: navigation)
            .disposed(by: disposeBag)
        
        input.sendAuthButtonTapped
            .withLatestFrom(input.inputPhoneNumber)
            .withUnretained(self)
            .subscribe(onNext: { viewModel, number in
                guard let number = number else { return }
                viewModel.navigation.onNext(.send(number))
            })
            .disposed(by: disposeBag)
        
        return Output()
    }
}
