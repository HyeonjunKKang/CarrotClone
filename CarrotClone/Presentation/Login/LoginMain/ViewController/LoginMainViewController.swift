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
        $0.font = .boldSystemFont(ofSize: 20)
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
        $0.backgroundColor = .carrotColor.carrot1
        $0.setTitle("시작하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    }
    
    private let doYouHaveEmailLabel = UILabel().then {
        $0.text = "이미 계정이 있나요?"
        $0.textColor = .carrotColor.gray1
        $0.font = .systemFont(ofSize: 15)
    }
    
    private let loginButton = UIButton().then {
        $0.backgroundColor = .none
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(.carrotColor.carrot1, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
    }
    
    // MARK: - Properties
    
    let viewModel: LoginMainViewModel
    
    // MARK: - Inits
    
    init(viewModel: LoginMainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Bind
    
    override func bind() {
        let input = LoginMainViewModel.Input(
            signupStartButtonTap: signupStartButton.rx.tap
                .throttle(.seconds(1), scheduler: MainScheduler.asyncInstance),
            loginButtonTap: loginButton.rx.tap
                .throttle(.seconds(1), scheduler: MainScheduler.asyncInstance),
            viewDidLoad: rx.viewWillAppear.map { _ in }.take(1)
        )
        
        let output = viewModel.transform(input: input)
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
        
        view.addSubview(signupStartButton)
        
        signupStartButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(115)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().inset(15)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        view.addSubview(doYouHaveEmailLabel)
        
        doYouHaveEmailLabel.snp.makeConstraints {
            $0.top.equalTo(signupStartButton.snp.bottom).offset(15)
            $0.centerX.equalToSuperview().offset(-20)
        }
        
        view.addSubview(loginButton)
        
        loginButton.snp.makeConstraints {
            $0.centerY.equalTo(doYouHaveEmailLabel)
            $0.leading.equalTo(doYouHaveEmailLabel.snp.trailing).offset(4)
        }
    }
}
