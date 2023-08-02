//
//  Encodable+Dictionary.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/07/31.
//

import Foundation

extension Encodable {
    func toDictionary() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self),
              let jsonData = try? JSONSerialization.jsonObject(with: data),
              let dictionaryData = jsonData as? [String: Any] else { return [:] }
        
        return dictionaryData
    }
}
