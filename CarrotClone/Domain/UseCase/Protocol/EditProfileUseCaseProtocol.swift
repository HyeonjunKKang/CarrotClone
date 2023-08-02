//
//  EditProfileUseCaseProtocol.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/08/01.
//

import UIKit
import RxSwift

protocol EditProfileUseCaseProtocol {
    func editProfile(name: String, image: UIImage) -> Observable<Void>
}
