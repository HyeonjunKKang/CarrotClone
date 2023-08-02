//
//  UserDataSourceProtocol.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/07/31.
//

import Foundation
import RxSwift

protocol UserDataSourceProtocol {
    func read(uid: String) -> Observable<UserResponseDTO>
    func exitsUserData(uid: String) -> Observable<Bool>
    func edit(request: UserRequestDTO) -> Observable<UserResponseDTO> 
    func uploadProfileImage(id: String, imageData: Data) -> Observable<URL>
}
