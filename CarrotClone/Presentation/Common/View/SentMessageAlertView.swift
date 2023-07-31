//
//  SentMessageAlertView.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/07/31.
//

import UIKit

final class SentMessageAlertView: UIView {
    
    private let textLabel = UILabel().then {
        $0.text = "인증번호가 문자로 전송됐습니다.(최대 20초 소요)"
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 13, weight: .semibold)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        self.backgroundColor = .black
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
        
        self.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        
        addSubview(textLabel)
        
        textLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(5)
        }
    }
}
