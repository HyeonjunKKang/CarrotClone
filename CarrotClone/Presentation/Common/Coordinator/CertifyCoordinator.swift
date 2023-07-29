//
//  CertifyCoordinator.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/07/15.
//

import UIKit
import RxSwift

enum CertifyCoordinatorResult {
    case finish(Bool)
    case back
}

final class CertifyCoordinator: BaseCoordinator<CertifyCoordinatorResult> {
    
    let phoneNumber: String
    let finish = PublishSubject<CertifyCoordinatorResult>()
    
    init(phoneNumber: String, _ navigationController: UINavigationController) {
        self.phoneNumber = phoneNumber
        super.init(navigationController)
    }
    
    override func start() -> Observable<CertifyCoordinatorResult> {
        showCertify()
        return finish
            .do(onNext: { [weak self] in
                switch $0 {
                case .finish: self?.pop(animated: false)
                case .back: self?.pop(animated: true)
                }
            })
    }
    
    func showCertify(){
        guard let viewModel = DIContainer.shared.container.resolve(CertifyViewModel.self) else { return }
        
        viewModel.inputPhonenumber.onNext(phoneNumber)
        
        viewModel.navigation
            .subscribe(onNext: { [weak self] in
                switch $0 {
                case .back:
                    self?.finish.onNext(.back)
                case .finish:
                    break
                }
            })
            .disposed(by: disposeBag)
        
        let viewController = CertifyViewController(viewModel: viewModel)

        push(viewController, animated: true)
    }
}
