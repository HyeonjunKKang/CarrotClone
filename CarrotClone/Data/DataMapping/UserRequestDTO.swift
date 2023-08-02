//
//  UserRequestDTO.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/07/31.
//

import Foundation

struct UserRequestDTO: Encodable {
    let uid: String
    let profileImageURLString: String?
    let email: String
    let name: String
    
    func toResponse() -> UserResponseDTO {
        return UserResponseDTO(
            uid: uid,
            profileImageURLString: profileImageURLString,
            email: email,
            name: name)
    }
}
