//
//  BoardCoordinator.swift
//  CarrotClone
//
//  Created by juyeong koh on 2023/08/03.
//

import Foundation
import RxSwift

enum BoardCoordinatorResult {
    case finish
}

final class BoardCoordinator: BaseCoordinator<MyCarrotCoordinatorResult> {
    
    let finish = PublishSubject<MyCarrotCoordinatorResult>()
    
    override func start() -> Observable<MyCarrotCoordinatorResult> {
        showMyCarrot()
        return finish
    }
    
    // MARK: - 로그인
    
    func showMyCarrot() {
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
        
        let viewController = BoardViewController()
        push(viewController, animated: true, isRoot: true)
    }
}
