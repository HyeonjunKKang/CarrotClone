//
//  PhotoCCollectionViewCell+Rx.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/08/14.
//

import UIKit
import RxSwift

extension Reactive where Base: PhotoCollectionViewCell {
    var selected: Binder<Photo> {
        return Binder(base) { base, photo in
            if photo.checked == true {
                base.contentView.backgroundColor = UIColor(white: 0.7, alpha: 0.5) // 어두운 배경 색
                base.layer.borderWidth = 2.0
                base.layer.borderColor = UIColor.carrotColor.carrot1?.cgColor
            } else {
                base.contentView.backgroundColor = UIColor(white: 0.7, alpha: 0) // 어두운 배경 색
                base.layer.borderWidth = 0
            }
        }
    }
}
