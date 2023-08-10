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
        let viewDidLoad: Observable<Void>
    }
    
    struct Output {
        
    }
    
    let navigation = PublishSubject<LoginMainNavigation>()
    var autologinUsecase: AutoLoginUseCaseProtocol?
    var disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {

        input.signupStartButtonTap
            .map { .signup }
            .bind(to: navigation)
            .disposed(by: disposeBag)
        
        input.loginButtonTap
            .map { .login }
            .bind(to: navigation)
            .disposed(by: disposeBag)
        
        input.viewDidLoad
            .withUnretained(self)
            .flatMap { $0.0.autologinUsecase?.load() ?? .empty()}
            .compactMap { $0 }
            .filter { $0.count >= 5 }
            .map { _ in .autologin }
            .bind(to: navigation)
            .disposed(by: disposeBag)
        
        return Output()
    }
}
