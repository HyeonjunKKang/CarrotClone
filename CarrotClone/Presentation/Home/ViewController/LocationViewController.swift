//
//  LocationViewController.swift
//  CarrotClone
//
//  Created by juyeong koh on 2023/08/13.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then
import MapKit

final class LocationViewController: ViewController {
    
    // MARK: - Properties
    
    lazy var titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.text = "이웃과 만나서\n거래하고 싶은 장소를 선택해주세요."
    }
    
    lazy var subLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15, weight: .regular)
        $0.textColor = .black
        $0.text = "만나서 거래할 때는 누구나 찾기 쉬운 공공장소가 좋아요."
    }
    
    lazy var completeButton = UIButton().then {
        $0.layer.cornerRadius = 7
        $0.clipsToBounds = true
        $0.backgroundColor = .orange
        $0.setTitle("선택 완료", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
    }
    
    let map = MKMapView()

    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
    
    // MARK: - Functions
    
    // MARK: - Layouts
    
    override func bind() {
    }
    
    override func layout() {
        
        [titleLabel, subLabel, map, completeButton]
            .forEach { view.addSubview($0) }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        subLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(7)
            $0.leading.equalToSuperview().offset(20)
        }
        
        map.snp.makeConstraints {
            $0.top.equalTo(subLabel.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalTo(self.view)
        }
        
        completeButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            $0.height.equalTo(50)
        }
        
        
    }

}
