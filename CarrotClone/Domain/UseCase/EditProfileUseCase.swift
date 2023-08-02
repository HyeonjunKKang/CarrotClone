//
//  EditProfileUseCase.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/08/01.
//

import UIKit
import RxSwift

struct EditProfileUseCase: EditProfileUseCaseProtocol {
    
    enum EditProfileUseCaseError: Error, LocalizedError {
        case imageCompressError
    }
    
    var userRepository: UserRepositoryProtocol?
    
    func editProfile(name: String, image: UIImage) -> Observable<Void> {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            return Observable.error(EditProfileUseCaseError.imageCompressError)
        }

        return (userRepository?.load() ?? .empty())
            .map {
                return User(uid: $0.uid, profileImageURLString: $0.uid, email: $0.email, name: name)
            }
            .flatMap { userRepository?.edit(user: $0, imageData: imageData) ?? .empty() }
            .map { _ in return () }
    }
}
