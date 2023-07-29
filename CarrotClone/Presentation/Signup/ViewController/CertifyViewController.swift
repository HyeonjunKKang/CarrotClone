//
//  CertifyViewController.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/07/15.
//

import UIKit
import RxSwift
import Then
import SnapKit

final class CertifyViewController: ViewController {
    
    // MARK: - Components
    
    private let phonenumberTextField = UITextField().then {
        $0.textColor = .black
        $0.isEnabled = false
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.layer.cornerRadius = 5
        $0.layer.borderColor = UIColor.carrotColor.lightgray1?.cgColor ?? UIColor.lightGray.cgColor
        $0.layer.borderWidth = 1
        $0.clipsToBounds = true
        
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        $0.leftViewMode = .always
    }
    
    private let sendAuthMessageButton = UIButton().then {
        $0.setTitle("인증문자 다시 받기", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
        $0.layer.borderColor = UIColor.carrotColor.lightgray1?.cgColor ?? UIColor.lightGray.cgColor
        $0.layer.borderWidth = 1
    }
    
    private let certifynumberInputTextField = UITextField().then {
        $0.keyboardType = .numberPad
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.placeholder = "인증번호 입력"
        $0.layer.cornerRadius = 5
        $0.layer.borderColor = UIColor.carrotColor.lightgray1?.cgColor ?? UIColor.lightGray.cgColor
        $0.layer.borderWidth = 1
        $0.clipsToBounds = true
        
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        $0.leftViewMode = .always
    }
    
    private let dontShareLabel = UILabel().then {
        $0.text = "어떤 경우에도 타인에게 공유하지 마세요!"
        $0.font = .systemFont(ofSize: 13)
        $0.textColor = .lightGray
    }
    
    private let certifyAndStartButton = UIButton().then {
        $0.setTitle("동의하고 시작하기", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        $0.setTitleColor(UIColor.lightGray, for: .normal)
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
        $0.backgroundColor = UIColor.carrotColor.gray2
        $0.setTitleColor(UIColor.carrotColor.gray3, for: .normal)
        $0.isEnabled = false
    }
    
    // MARK: - Components
    
    let viewModel: CertifyViewModel
    
    // MARK: - Inits
    
    init(viewModel: CertifyViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Bind
    override func bind() {
        let input = CertifyViewModel.Input(
            backButtonTapped: backButton.rx.tap
                .throttle(.seconds(1), scheduler: MainScheduler.instance),
            viewWillAppear: rx.viewWillAppear.map { _ in }.asObservable(),
            resendButtonTapped: sendAuthMessageButton.rx.tap
                .throttle(.seconds(1), scheduler: MainScheduler.instance),
            certifyAndStartButtonTapped: certifyAndStartButton.rx.tap
                .throttle(.seconds(1), scheduler: MainScheduler.instance),
            AuthenticationNumber: certifynumberInputTextField.rx.text.orEmpty.asObservable()
        )
        
        let output = viewModel.transform(input: input)
        
        output.inputPhonenumber
            .drive(phonenumberTextField.rx.text)
            .disposed(by: disposeBag)
        
        output.countingResendButtonText
            .drive(sendAuthMessageButton.rx.title)
            .disposed(by: disposeBag)
        
        bindcertifynumberInputTextField()
        bindCertifyAndStartButton()
    }
    
    func bindcertifynumberInputTextField() {
        certifynumberInputTextField.rx.isFirstResponder
            .withUnretained(self)
            .subscribe(onNext: { vc, bool in
                if bool {
                    vc.certifynumberInputTextField.layer.borderColor = UIColor.black.cgColor
                } else {
                    vc.certifynumberInputTextField.layer.borderColor = UIColor.carrotColor.lightgray1?.cgColor ?? UIColor.lightGray.cgColor
                }
            })
            .disposed(by: disposeBag)
    }
    
    func bindCertifyAndStartButton(){
        let buttonEnable = certifynumberInputTextField.rx.text
            .compactMap { $0?.count }
            .map { $0 >= 1 ? true : false }
            
        buttonEnable
            .bind(to: certifyAndStartButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        buttonEnable
            .subscribe(onNext: { [weak self] in
                switch $0{
                case false:
                    self?.certifyAndStartButton.backgroundColor = UIColor.carrotColor.gray2
                    self?.certifyAndStartButton.setTitleColor(UIColor.carrotColor.gray3, for: .normal)
                case true:
                    self?.certifyAndStartButton.backgroundColor = UIColor.carrotColor.carrot1
                    self?.certifyAndStartButton.setTitleColor(UIColor.white, for: .normal)
                }
            })
            .disposed(by: disposeBag)
        
        
    }
    
    // MARK: - Layout
    
    override func layout() {
        view.addSubview(phonenumberTextField)
        
        phonenumberTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(45)
        }
        
        view.addSubview(sendAuthMessageButton)
        
        sendAuthMessageButton.snp.makeConstraints {
            $0.top.equalTo(phonenumberTextField.snp.bottom).offset(15)
            $0.leading.trailing.equalTo(phonenumberTextField)
            $0.height.equalTo(45)
        }
        
        view.addSubview(certifynumberInputTextField)
        
        certifynumberInputTextField.snp.makeConstraints {
            $0.top.equalTo(sendAuthMessageButton.snp.bottom).offset(15)
            $0.leading.trailing.equalTo(sendAuthMessageButton)
            $0.height.equalTo(45)
        }
        
        view.addSubview(dontShareLabel)
        
        dontShareLabel.snp.makeConstraints {
            $0.top.equalTo(certifynumberInputTextField.snp.bottom).offset( 7)
            $0.leading.trailing.equalTo(certifynumberInputTextField)
        }
        
        view.addSubview(certifyAndStartButton)
        
        certifyAndStartButton.snp.makeConstraints {
            $0.top.equalTo(dontShareLabel.snp.bottom).offset(7)
            $0.leading.trailing.equalTo(dontShareLabel)
            $0.height.equalTo(45)
        }
    }
}
