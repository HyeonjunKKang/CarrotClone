//
//  LoginMainViewModel.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/07/14.
//

import Foundation
import RxSwift
import RxCocoa

enum LoginMainNavigation {
    case signup
    case login
    case autologin
}

final class LoginMainViewModel: ViewModel {
    
    struct Input {
        let signupStartButtonTap: Observable<Void>
        let loginButtonTap: Observable<Void>
    }
    
    struct Output {
        
    }
    
    let navigation = PublishSubject<LoginMainNavigation>()
    var disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        
        let a = Observable.from([3, 2, 1, 5, 6])
        let b = Observable.just(5)
        
        
        input.signupStartButtonTap
            .map { .signup }
            .bind(to: navigation)
            .disposed(by: disposeBag)
        
        input.loginButtonTap
            .map { .login }
            .bind(to: navigation)
            .disposed(by: disposeBag)
        
        
        return Output()
    }
}
