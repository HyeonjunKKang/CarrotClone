//
//  PhotoRepository.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/08/10.
//

import RxSwift
import Photos
import UIKit

struct PhotoRepository: PhotoRepositoryProtocol {
    
    func fetchPHAsset() -> Observable<[Photo]> {
        return Observable.create { emitter in
            
            let phFetchOptions = PHFetchOptions()
            phFetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
            
            let fetchResult = PHAsset.fetchAssets(with: phFetchOptions)
            var assetsArray: [Photo] = []
            
            let camera = Photo(image: UIImage(systemName: "camera") ?? UIImage(), identifier: "camera")
            assetsArray.append(camera)
            
            let imageManager = PHCachingImageManager()
            
            fetchResult.enumerateObjects { asset, _, _ in
                imageManager.requestImage(
                    for: asset,
                    targetSize: CGSize(
                        width: SelectPhotoViewController.Constraint.cellWidth,
                        height: SelectPhotoViewController.Constraint.cellWidth
                    ),
                    contentMode: .default,
                    options: nil) { image, _ in
                        guard let image = image else { return }
                        let photo = Photo(image: image, identifier: asset.localIdentifier)
                        assetsArray.append(photo)
                    }
            }

            
            emitter.onNext(assetsArray)
            
            return Disposables.create()
        }
    }
    
}
