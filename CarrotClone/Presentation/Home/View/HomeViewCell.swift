//
//  HomeViewCell.swift
//  CarrotClone
//
//  Created by juyeong koh on 2023/07/22.
//

import UIKit
import Then
import SnapKit

class HomeViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "HomeViewCell"
    
    private let titleImage = UIImageView().then {
        $0.image = UIImage(named: "titleImage")
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .bold)
        $0.textColor = .black
        $0.text = "아이패드"
    }
    
    private let subtitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 11)
        $0.textColor = .gray
        $0.text = "상현 2동"
    }
    
    private let priceLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .bold)
        $0.textColor = .black
        $0.text = "3,000원"
    }
    
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
        titleLabel.textColor = .black
    }
    
    func setUpLayout() {
        
        [titleImage, titleLabel, subtitleLabel, priceLabel]
            .forEach { self.addSubview($0) }
        
        titleImage.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(10)
            $0.leading.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(-10)
            $0.width.equalTo(100)
            $0.height.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(13)
            $0.leading.equalTo(titleImage.snp.trailing).offset(7)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(7)
            $0.leading.equalTo(titleLabel.snp.leading)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(7)
            $0.leading.equalTo(subtitleLabel.snp.leading)
        }
        
    }
}
