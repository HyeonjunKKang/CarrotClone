//
//  RxUIViewController + Alert.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/07/31.
//

import UIKit
import RxSwift
import RxCocoa

struct Alert {
    let title: String
    let message: String
    let observer: AnyObserver<Void>?
}

extension Reactive where Base: UIViewController {
    var presentActionSheet: Binder<Alert> {
        return Binder(base) { base, alert in
            let alertController = UIAlertController(title: alert.title, message: alert.message, preferredStyle: .actionSheet)
            
            let okAction = UIAlertAction(title: "확인", style: .default, handler: { _ in
                alert.observer?.onNext(())
            })
            
            let cancleAction = UIAlertAction(title: "취소", style: .cancel, handler: { _ in
                alert.observer?.onCompleted()
            })
            
            alertController.addAction(okAction)
            alertController.addAction(cancleAction)
            base.present(alertController, animated: true)
        }
    }
}
