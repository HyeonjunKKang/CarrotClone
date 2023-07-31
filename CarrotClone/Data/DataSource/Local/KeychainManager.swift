//
//  KeychainManager.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/07/29.
//

import Foundation

enum KeychainKey: String {
    case verificationID = "com.CarrotClone.verificationID"
    case uid = "com.CarrotClone.uid"
    case fcmToken = "com.codershigh.CarrotClone.fcmToken"
    case authorization = "com.codershigh.boostcamp.Mogakco.authorization"
}

struct KeychainManager:  KeychainManagerProtocol {
    
    var keychain: KeychainProtocol?
    
    func save(key: KeychainKey, data: Data) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue,
            kSecValueData as String: data
        ]
        
        let status = keychain?.add(query)
        return status == errSecSuccess ? true : false
    }
    
    func load(key: KeychainKey) -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        return keychain?.search(query)
    }
    
    func delete(key: KeychainKey) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue
        ]
        
        let status = keychain?.delete(query)
        return status == errSecSuccess ? true : false
    }
    
    func update(key: KeychainKey, data: Data) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue
        ]
        
        let attributes: [String: Any] = [
            kSecAttrAccount as String: key.rawValue,
            kSecValueData as String: data
        ]

        let status = keychain?.update(query, with: attributes)
        return status == errSecSuccess ? true : false
    }
}
