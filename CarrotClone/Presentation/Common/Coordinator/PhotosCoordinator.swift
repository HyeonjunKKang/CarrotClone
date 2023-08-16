//
//  PhotosCoordinator.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/08/10.
//

import Foundation
import RxSwift

enum PhotosCoordinatorResult {
    case finish
}

final class PhotosCoordinator: BaseCoordinator<PhotosCoordinatorResult> {
    
    let finish = PublishSubject<PhotosCoordinatorResult>()
    
    override func start() -> Observable<PhotosCoordinatorResult> {
        showSelectPhoto()
        return finish
    }
    
    // MARK: - 로그인
    
    func showSelectPhoto() {
        guard let viewModel = DIContainer.shared.container.resolve(SelectPhotoViewModel.self) else { return }
//
//        viewModel.navigation
//            .subscribe(onNext: { [weak self] in
//                switch $0 {
//                case .signup:
//                    self?.showSignup()
//                case .login:
//                    self?.showLogin()
//                case .autologin:
//                    self?.finish.onNext(.finish)
//                }
//            })
//            .disposed(by: disposeBag)
////
        let viewController = SelectPhotoViewController(viewModel: viewModel)
        push(viewController, animated: true, isRoot: true)
    }
    
//    // MARK: - 로그인
//    func showLogin() {
//        let login = LoginCoordinator(navigationController)
//
//        coordinate(to: login)
//            .subscribe(onNext: { [weak self] in
//                switch $0 {
//                case .finish:
//                    self?.finish.onNext(.finish)
//                case .back:
//                    self?.setNavigationBarHidden(true, animated: false)
//                }
//            })
//            .disposed(by: disposeBag)
//    }
//
//    // MARK: - 회원가입 (번호)
//
//    func showSignup() {
//        let signup = SignupCoordinator(navigationController)
//
//        coordinate(to: signup)
//            .subscribe(onNext: { [weak self] in
//                switch $0 {
//                case .finish:
//                    self?.finish.onNext(.finish)
//                case .back:
//                    self?.setNavigationBarHidden(true, animated: false)
//                }
//            })
//            .disposed(by: disposeBag)
//    }
}
