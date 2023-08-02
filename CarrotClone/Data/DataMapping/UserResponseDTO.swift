//
//  UserResponseDTO.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/07/31.
//

import Foundation

struct UserResponseDTO: Decodable {
    let uid: String
    let profileImageURLString: String?
    let email: String
    let name: String
    
    func toDomain() -> User {
        return User(
            uid: uid,
            profileImageURLString: profileImageURLString,
            email: email,
            name: name)
    }
}
