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
        let viewController = CertifyViewController()
        viewController.number = phoneNumber
        push(viewController, animated: true)
    }
}
