//
//  SelectNumberView+Rx.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/08/14.
//

import UIKit
import RxSwift

extension Reactive where Base: SelectNumberView {
    var select: Binder<Photo> {
        return Binder(base) { view, photo in
            if photo.checked == true {
                view.layer.borderColor = UIColor.clear.cgColor
                view.backgroundColor = UIColor.carrotColor.carrot1
                view.numberLabel.text = String(photo.checkedNumber)
            } else {
                view.backgroundColor = UIColor.clear // 배경 투명 설정
                view.layer.borderWidth = 2.0 // 테두리 두께
                view.layer.borderColor = UIColor.white.cgColor // 테두리 색상
                view.numberLabel.text = ""
            }
        }
    }
}
