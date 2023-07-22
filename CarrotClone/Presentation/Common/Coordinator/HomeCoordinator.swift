//
//  HomeCoordinator.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/07/12.
//

import Foundation
import RxSwift

enum HomeCoordinatorResult {
    case finish
}

final class HomeCoordinator: BaseCoordinator<HomeCoordinatorResult> {
    
    let finish = PublishSubject<HomeCoordinatorResult>()
    
    override func start() -> Observable<HomeCoordinatorResult> {
        showLogin()
        return finish
    }
    
    // MARK: - 로그인
    
    func showLogin() {
//        guard let viewModel = DIContainer.shared.container.resolve(LoginViewModel.self) else { return }
        
//        viewModel.navigation
//            .subscribe(onNext: { [weak self] in
//                switch $0 {
//                case .signup:
//                    self?.showEmail()
//                case .finish:
//                    self?.finish.onNext(.finish)
//                }
//            })
//            .disposed(by: disposeBag)
//
//        let viewController = LoginViewController(viewModel: viewModel)
        
        let viewController = HomeViewController(viewModel: HomeViewModel())
        push(viewController, animated: true, isRoot: true)
    }
}
