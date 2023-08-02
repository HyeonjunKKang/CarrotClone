//
//  LoginCoordinator.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/07/31.
//

import Foundation
import RxSwift

enum LoginCoordinatorResult {
    case finish
    case back
}

final class LoginCoordinator: BaseCoordinator<LoginCoordinatorResult> {
    
    let finish = PublishSubject<LoginCoordinatorResult>()
    
    override func start() -> Observable<LoginCoordinatorResult> {
        showLogin()
        return finish
            .do(onNext: { [weak self] in
                switch $0 {
                case .finish: self?.pop(animated: false)
                case .back: self?.pop(animated: true)
                }
            })
    }
    
    // MARK: - 로그인

    func showLogin() {
        guard let viewModel = DIContainer.shared.container.resolve(LoginViewModel.self) else { return }
        
        viewModel.navigation
            .subscribe(onNext: { [weak self] in
                switch $0 {
                case .back:
                    self?.finish.onNext(.back)
                case .send(let number):
                    self?.showCertify(phoneNumber: number)
                }
            })
            .disposed(by: disposeBag)
        
        let viewController = LoginViewController(viewModel: viewModel)
        push(viewController, animated: true)
    }
    
    func showCertify(phoneNumber: String) {
        guard let viewModel = DIContainer.shared.container.resolve(CertifyViewModel.self) else { return }
        
        viewModel.inputPhonenumber.onNext(phoneNumber)
        
        viewModel.navigation
            .subscribe(onNext: { [weak self] in
                switch $0 {
                case .back:
                    self?.finish.onNext(.back)
                case .finish:
                    self?.finish.onNext(.finish)
                }
            })
            .disposed(by: disposeBag)
        
        let viewController = CertifyViewController(viewModel: viewModel)
        push(viewController, animated: true)
    }
}

