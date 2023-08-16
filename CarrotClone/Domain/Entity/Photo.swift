//
//  Photo.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/08/10.
//

import UIKit
import Photos

struct Photo {
    let image: UIImage
    let identifier: String
    var checked: Bool = false
    var checkedNumber: Int = 0
    
    mutating func check() {
        checked = true
        checkedNumber = Photo.selectedIndex
        Photo.selectedIndex += 1
    }
    
    mutating func uncheck() {
        Photo.selectedIndex -= 1
        checked = false
        checkedNumber = Photo.selectedIndex
    }
    
    static var selectedIndex: Int = 1
}
