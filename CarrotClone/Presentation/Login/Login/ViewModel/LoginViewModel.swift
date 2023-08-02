//
//  LoginViewModel.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/07/31.
//

import Foundation
import RxSwift

enum LoginNavigaion {
    case back
    case send(String)
}

final class LoginViewModel: ViewModel {
    struct Input {
        let backButtonTapped: Observable<Void>
        let sendAuthButtonTapped: Observable<Void>
        let inputPhoneNumber: Observable<String?>
    }
    
    struct Output {
        
    }
    
    var disposeBag = DisposeBag()
    let navigation = PublishSubject<LoginNavigaion>()
    
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
