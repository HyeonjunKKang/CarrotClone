//
//  KeychainManagerProtocol.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/07/29.
//

import Foundation

protocol KeychainManagerProtocol {
    func save(key: KeychainKey, data: Data) -> Bool
    func load(key: KeychainKey) -> Data?
    func delete(key: KeychainKey) -> Bool
    func update(key: KeychainKey, data: Data) -> Bool
}
