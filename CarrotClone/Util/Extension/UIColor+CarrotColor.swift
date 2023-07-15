//
//  UIColor+CarrotColor.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/07/14.
//

import UIKit

extension UIColor {
    static let carrotColor = CarrotColor()
}

struct CarrotColor {
    /// 당근색 237 119 50
    let carrot1 = UIColor(named: "Carrot1")
    
    /// 회색 142 146 154
    let gray1 = UIColor(named: "gray1")
    
    /// 회색 223 224 249
    let lightgray1 = UIColor(named: "lightgray1")
}
