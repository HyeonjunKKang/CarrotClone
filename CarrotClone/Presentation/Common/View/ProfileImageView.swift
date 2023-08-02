//
//  ProfileImageView.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/07/31.
//

import UIKit
import SnapKit
import Then

final class ProfileImageView: UIView {
    
    let button = UIButton().then {
        $0.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        $0.clipsToBounds = true
        $0.tintColor = .gray
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.carrotColor.lightgray1?.cgColor
    }
    
    lazy var imageView = UIImageView().then {
        $0.image = UIImage(named: "person")
        $0.clipsToBounds = true
        $0.backgroundColor = .carrotColor.gray2
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.carrotColor.gray2?.cgColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        addSubview(button)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
          
        imageView.layer.cornerRadius = imageView.frame.height / 2
        
        let buttonSize: CGFloat = imageView.frame.height / 3
        let buttonX = imageView.frame.maxX - buttonSize
        let buttonY = imageView.frame.maxY - buttonSize
        button.frame = CGRect(x: buttonX, y: buttonY, width: buttonSize, height: buttonSize)
        
        button.layer.cornerRadius = button.frame.height / 2
      }
}

