//
//  AppCoordinator.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/07/05.
//

import UIKit
import RxSwift

final class AppCoordinator: BaseCoordinator<Void> {
    let window: UIWindow?
    
    init(_ window: UIWindow?) {
        self.window = window
        super.init(UINavigationController())
    }
    
    private func setup(with window: UIWindow?) {
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white
    }
    
    override func start() -> Observable<Void> {
        setup(with: window)
        showLogin()
//        showTab()
        return Observable.never()
    }
    
    private func showLogin() {
        navigationController.setNavigationBarHidden(true, animated: true)
        let login = LoginCoordinator(navigationController)
        coordinate(to: login)
            .subscribe(onNext: { [weak self] in
                switch $0 {
                case .finish:
                    self?.showTab()
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
    }

    private func showTab() {
//        navigationController.setNavigationBarHidden(false, animated: true)
//        let tab = TabCoordinator(navigationController)
//        coordinate(to: tab)
//            .subscribe(onNext: { [weak self] in
//                switch $0 {
//                case .finish:
//                    break
//                default:
//                    break
//                }
//            })
//            .disposed(by: disposeBag)
//
    }
}
