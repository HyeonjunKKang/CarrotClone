//
//  BaseCoordinator.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/07/05.
//

import UIKit
import RxSwift

class BaseCoordinator<ResultType> {
    
    typealias CoordinationResult = ResultType
    
    private let identifier = String(describing: ResultType.self)
    private var childCoordinators: [String: Any] = [:]
    let navigationController: UINavigationController
    let disposeBag = DisposeBag()
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() -> Observable<ResultType> {
        fatalError("Start method should be implemented!!")
    }
    
    // MARK: - Child Coordinator
    
    /// append(coordinator:) 메서드: 자식 코디네이터를 추가합니다. 다른 코디네이터를 BaseCoordinator의 자식으로 추가하여 계층 구조를 형성할 수 있습니다. 자식 코디네이터는 identifier를 키로 사용하여 childCoordinators 딕셔너리에 저장됩니다.
    private func append<T>(coordinator: BaseCoordinator<T>) {
        childCoordinators[coordinator.identifier] = coordinator
    }
    
    /// remove(coordinator:) 메서드: 자식 코디네이터를 제거합니다. append(coordinator:) 메서드를 사용하여 추가한 자식 코디네이터를 제거합니다.
    private func remove<T>(coordinator: BaseCoordinator<T>) {
        childCoordinators[coordinator.identifier] = nil
    }
    
    /// coordinate(to:) 메서드: 다른 코디네이터로의 네비게이션을 시작합니다. 다른 코디네이터의 start() 메서드를 호출하여 해당 코디네이터를 실행하고, 실행 결과를 Observable로 반환합니다. 실행이 완료된 후에는 자식 코디네이터를 제거합니다.
    func coordinate<T>(to coordinator: BaseCoordinator<T>) -> Observable<T> {
        append(coordinator: coordinator)
        return coordinator.start()
            .do(onNext: { [weak self] _ in self?.remove(coordinator: coordinator) })
    }
    
    // MARK: - Push ∙ Pop
    
    /// push(_:animated:isRoot:) 메서드: 새로운 뷰 컨트롤러를 네비게이션 스택에 푸시합니다. animated 매개변수를 사용하여 애니메이션 효과를 적용할 수 있으며, isRoot 매개변수를 사용하여 루트 뷰 컨트롤러로 설정할 수 있습니다.
    func push(_ viewController: UIViewController, animated: Bool, isRoot: Bool = false) {
        if isRoot {
            navigationController.viewControllers = [viewController]
        } else {
            navigationController.pushViewController(viewController, animated: animated)
        }
    }
    
    /// presentTabbar(_:animated:) 메서드: 탭바 컨트롤러에 모달로 새로운 뷰 컨트롤러를 프레젠테이션합니다.
    func pushTabbar(_ viewController: UIViewController, animated: Bool) {
        navigationController.tabBarController?.navigationController?.pushViewController(
            viewController,
            animated: animated
        )
    }
    
    /// pop(animated:) 메서드: 현재 뷰 컨트롤러를 네비게이션 스택에서 팝합니다. animated 매개변수를 사용하여 애니메이션 효과를 적용할 수 있습니다
    func pop(animated: Bool) {
        if navigationController.viewControllers.count == 1 {
            navigationController.viewControllers = []
        } else {
            navigationController.popViewController(animated: animated)
        }
    }
    
    func popTabbar(animated: Bool) {
        navigationController.tabBarController?.navigationController?.popViewController(animated: animated)
    }
    
    // MARK: - Present ∙ Dismiss
    
    func presentTabbar(_ viewController: UIViewController, animated: Bool) {
        navigationController.tabBarController?.present(viewController, animated: animated)
    }
    
    func dismissTabbar(animated: Bool) {
        navigationController.tabBarController?.dismiss(animated: animated)
    }
    
    // MARK: - Navigation Bar Hidden
    
    /// setTabbarNavigationBarHidden(_:animated:) 메서드: 탭바 컨트롤러의 네비게이션 컨트롤러의 네비게이션 바의 가시성(hidden)을 설정합니다.
    func setTabbarNavigationBarHidden(_ hidden: Bool, animated: Bool) {
        navigationController.tabBarController?.navigationController?.setNavigationBarHidden(
            hidden,
            animated: animated
        )
    }
    
    /// setNavigationBarHidden(_:animated:) 메서드: 네비게이션 컨트롤러의 네비게이션 바의 가시성(hidden)을 설정합니다.
    func setNavigationBarHidden(_ hidden: Bool, animated: Bool) {
        navigationController.setNavigationBarHidden(hidden, animated: animated)
    }
    
    func setTabBarHidden(_ hidden: Bool) {
        navigationController.tabBarController?.tabBar.isHidden = hidden
    }
}
