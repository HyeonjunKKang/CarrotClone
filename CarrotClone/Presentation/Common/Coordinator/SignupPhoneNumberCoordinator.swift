//
//  SignupPhoneNumberCoordinator.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/07/15.
//

import Foundation
import RxSwift

enum SignupPhoneNumberCoordinatorResult {
    case finish(Bool)
    case back
}

final class SignupPhoneNumberCoordinator: BaseCoordinator<SignupPhoneNumberCoordinatorResult> {
    
    let finish = PublishSubject<SignupPhoneNumberCoordinatorResult>()
    
    override func start() -> Observable<SignupPhoneNumberCoordinatorResult> {
        showSignupPhoneNumber()
        setNavigationBarHidden(false, animated: true)
        return finish
            .do(onNext: { [weak self] in
                switch $0 {
                case .finish: self?.pop(animated: false)
                case .back: self?.pop(animated: true)
                }
            })
    }
    
    func showSignupPhoneNumber() {
        guard let viewModel = DIContainer.shared.container.resolve(SignupPhoneNumberViewModel.self) else { return }
        
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
        
        let viewController = SignupPhoneNumberViewController(viewModel: viewModel)
        push(viewController, animated: true)
    }
    
    func showCertify(phoneNumber: String) {
        let certify = CertifyCoordinator(phoneNumber: phoneNumber, navigationController)
        
        coordinate(to: certify)
            .subscribe(onNext: { [weak self] in
                switch $0 {
                case .back:
                    self?.finish.onNext(.back)
                case .finish(let bool):
                    break
                }
            })
            .disposed(by: disposeBag)
    }
    
}
