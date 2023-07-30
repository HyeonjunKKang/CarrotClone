//
//  TabCoordinator.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/07/12.
//

import Foundation
import RxSwift
import UIKit

enum TabCoordinatorResult {
    case finish
}

final class TabCoordinator: BaseCoordinator<TabCoordinatorResult> {
    
    enum Tab: Int, CaseIterable {
        case home
        case chat
        case profile

        var title: String {
            switch self {
            case .home: return "홈"
            case .chat: return "채팅"
            case .profile: return "나의당근"
            }
        }

        var image: String {
            switch self {
            case .home: return "house.fill"
            case .chat: return "bubble.right.fill"
            case .profile: return "person.crop.circle"
            }
        }
    }
    
    private var tabBarController = UITabBarController()
    private let finish = PublishSubject<TabCoordinatorResult>()
    
    override func start() -> Observable<TabCoordinatorResult> {
        push(tabBarController, animated: true, isRoot: true)
        setup()
        return finish
    }
    
    private func setup() {
        var rootViewControllers: [UINavigationController] = []
        
        Tab.allCases.forEach {
            let navigationController = navigationController(tab: $0)
            rootViewControllers.append(navigationController)
            
            switch $0 {
            case .home: showHome(navigationController)
            case .chat: showChat(navigationController)
            case .profile: showProfile(navigationController)
            }
        }
        
        tabBarController.setViewControllers(rootViewControllers, animated: false)
    }
    
    private func navigationController(tab: Tab) -> UINavigationController {
        let navigationController = UINavigationController()
        let tabBarItem = UITabBarItem(
            title: tab.title,
            image: UIImage(systemName: tab.image),
            tag: tab.rawValue
        )
        navigationController.tabBarItem = tabBarItem
        navigationController.isNavigationBarHidden = true
        return navigationController
    }
    
    private func showHome(_ root: UINavigationController) {
        let child = HomeCoordinator(root)
        coordinate(to: child)
            .subscribe(onNext: { [weak self] in
                switch $0 {
                case .finish:
                    self?.finish.onNext(.finish)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func showChat(_ root: UINavigationController) {
        let child = ChatListCoordinator(root)
//        coordinate(to: child)
//            .subscribe(onNext: { [weak self] in
//                switch $0 {
//                case .finish:
//                    self?.finish.onNext(.finish)
//                }
//            })
//            .disposed(by: disposeBag)
    }
    
    private func showProfile(_ root: UINavigationController) {
        let child = MyCarrotCoordinator(root)
//        coordinate(to: child)
//            .subscribe(onNext: { [weak self] in
//                switch $0 {
//                case .finish:
//                    self?.finish.onNext(.finish)
//                case .back:
//                    break
//                }
//            })
//            .disposed(by: disposeBag)
    }
}
