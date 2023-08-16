//
//  UIImageView+Rx.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/08/14.
//

import UIKit
import RxSwift
import Photos

extension Reactive where Base: UIImageView {
    var albumImage: Binder<PHAsset> {
        return Binder(base) { base, asset in
            
            let imageManager = PHCachingImageManager()
            
            imageManager.requestImage(
                for: asset,
                targetSize: CGSize(
                    width: SelectPhotoViewController.Constraint.cellWidth,
                    height: SelectPhotoViewController.Constraint.cellWidth),
                contentMode: .default,
                options: nil) { image, _ in
                    
                    base.image = image
                }
        }
    }
}
