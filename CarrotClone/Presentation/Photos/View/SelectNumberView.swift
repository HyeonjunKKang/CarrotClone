//
//  SelectNumberView.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/08/11.
//

import UIKit
import Then
import SnapKit
import RxCocoa
import RxSwift

final class SelectNumberView: UIView {
    
    let numberLabel = UILabel().then {
        $0.backgroundColor = .clear
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 15, weight: .bold)
    }
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            setup()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setup()
        }
    
    private func setup() {
        addSubview(numberLabel)
        
        numberLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.size.width / 2 // 원 형태로 둥글게 만들기
    }
}
