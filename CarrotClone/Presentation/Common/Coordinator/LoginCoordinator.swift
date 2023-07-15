//
//  LoginCoordinator.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/07/14.
//

import Foundation
import RxSwift

enum LoginCoordinatorResult {
    case finish
}

final class LoginCoordinator: BaseCoordinator<LoginCoordinatorResult> {
    
    let finish = PublishSubject<LoginCoordinatorResult>()
    
    override func start() -> Observable<LoginCoordinatorResult> {
        showLogin()
//        showSignup()
        return finish
    }
    
    // MARK: - 로그인
    
    func showLogin() {
        guard let viewModel = DIContainer.shared.container.resolve(LoginMainViewModel.self) else { return }
        
        viewModel.navigation
            .subscribe(onNext: { [weak self] in
                switch $0 {
                case .signup:
                    self?.showSignup()
                case .login:
                    break
                case .autologin:
                    self?.finish.onNext(.finish)
                }
            })
            .disposed(by: disposeBag)
//
        let viewController = LoginMainViewController(viewModel: viewModel)
        push(viewController, animated: true, isRoot: true)
    }
    
    // MARK: - 회원가입 (이메일)

    func showSignup() {
        let signup = SignupPhoneNumberCoordinator(navigationController)

        coordinate(to: signup)
            .subscribe(onNext: { [weak self] in
                switch $0 {
                case .finish(let result):
                    if result { self?.finish.onNext(.finish) }
                case .back:
                    break
                }
            })
            .disposed(by: disposeBag)
    }
}
