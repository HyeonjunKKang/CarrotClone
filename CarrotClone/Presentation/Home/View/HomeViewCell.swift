//
//  HomeViewCell.swift
//  CarrotClone
//
//  Created by juyeong koh on 2023/07/22.
//

import UIKit

class HomeViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "HomeViewCell"
    
    let titleLabel = UILabel()
    
    // MARK: - LifeCycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpLayout()
        setUpAttribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func setUpData(_ data: String) {
        titleLabel.text = data
    }
    
    func setUpAttribute() {
        titleLabel.font = .systemFont(ofSize: 14)
        titleLabel.textAlignment = .center
    }
    
    func setUpLayout() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
    }

    
}
