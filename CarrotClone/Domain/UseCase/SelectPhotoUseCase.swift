//
//  SelectPhotoUseCase.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/08/10.
//

import RxSwift

struct SelectPhotoUseCase: SelectPhotoUseCaseProtocol {
    var photoRepository: PhotoRepositoryProtocol?
    
    func fetchPhoto() -> Observable<[Photo]> {
        return photoRepository?.fetchPHAsset() ?? .empty()
    }
}
