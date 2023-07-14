//
//  LoginMainViewController.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/07/14.
//

import UIKit
import RxSwift
import Then
import SnapKit

final class LoginMainViewController: ViewController {
    
    // MARK: - Components
    
    private let mainImageView = UIImageView().then {
        $0.image = UIImage(named: "logo")
    }
    
    private let mainWellcomeLabel = UILabel().then {
        $0.text = "당신 근처의 당근마켓"
        $0.font = .boldSystemFont(ofSize: 18)
    }
    
    private let mainIntroduceLabel = UILabel().then {
        $0.text = "중고 거래부터 동네 정보까지,"
        $0.font = .systemFont(ofSize: 16)
    }
    
    private let subIntroduceLabel = UILabel().then {
        $0.text = "지금 내 동네를 선택하고 시작해보세요!"
        $0.font = .systemFont(ofSize: 16)
    }
    
    private let signupStartButton = UIButton().then {
        $0.setTitle("시작하기", for: .normal)
        
    }
    
    // MARK: - Inits
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
    }
    
    // MARK: - Methods
    
    override func layout() {
        
        view.addSubview(mainImageView)
        
        mainImageView.snp.makeConstraints {
            $0.width.equalTo(250)
            $0.height.equalTo(252)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-90)
        }
        
        view.addSubview(mainWellcomeLabel)
        
        mainWellcomeLabel.snp.makeConstraints {
            $0.top.equalTo(mainImageView.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        
        view.addSubview(mainIntroduceLabel)
        
        mainIntroduceLabel.snp.makeConstraints {
            $0.top.equalTo(mainWellcomeLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        view.addSubview(subIntroduceLabel)
        
        subIntroduceLabel.snp.makeConstraints {
            $0.top.equalTo(mainIntroduceLabel.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
    }
}
