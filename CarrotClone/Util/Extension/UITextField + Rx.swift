//
//  UITextField + Rx.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/07/15.
//

import UIKit
import RxCocoa
import RxSwift


extension Reactive where Base: UITextField {
    var isFirstResponder: ControlProperty<Bool> {
        return controlProperty(editingEvents: [.editingDidBegin, .editingDidEnd],
        getter: {
            $0.isFirstResponder
        }, setter: { textfield, isFirstResponder in
            if isFirstResponder == true {
                textfield.becomeFirstResponder()
            } else {
                textfield.resignFirstResponder()
            }
        })
    }
}

extension Reactive where Base: UIButton {
    var title: Binder<String> {
        return Binder(base) { button, string in
            button.setTitle(string, for: .normal)
        }
    }
}
