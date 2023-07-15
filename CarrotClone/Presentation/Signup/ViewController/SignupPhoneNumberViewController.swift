//
//  SignupPhoneNumberViewController.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/07/15.
//

import UIKit
import RxSwift
import Then
import SnapKit

final class SignupPhoneNumberViewController: ViewController {
    
    // MARK: - Components
    
    private let wellcomeLabel = UILabel().then {
        $0.numberOfLines = 2
        $0.text = "안녕하세요!\n휴대폰 번호로 가입해주세요."
        $0.font = .systemFont(ofSize: 24, weight: .bold)
        $0.backgroundColor = .white
        $0.textColor = .black
    }
    
    private let securityLabel = UILabel().then {
        $0.text = "휴대폰 번호는 안전하게 보관되며 이웃들에게 공개되지 않아요."
        $0.font = .systemFont(ofSize: 13)
        $0.backgroundColor = .white
        $0.textColor = .black
    }
    
    private let phonenumberInputTextField = UITextField().then {
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.placeholder = "휴대폰 번호(- 없이 숫자만 입력)"
        $0.layer.cornerRadius = 5
        $0.layer.borderColor = UIColor.carrotColor.lightgray1?.cgColor ?? UIColor.lightGray.cgColor
        $0.layer.borderWidth = 1
        $0.clipsToBounds = true
        
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        $0.leftViewMode = .always
    }
    
    private let sendAuthMessageButton = UIButton().then {
        $0.setTitle("인증문자 받기", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        $0.setTitleColor(UIColor.lightGray, for: .normal)
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
        $0.layer.borderColor = UIColor.carrotColor.lightgray1?.cgColor ?? UIColor.lightGray.cgColor
        $0.layer.borderWidth = 1
    }
    
    // MARK: - Properties
    
    let viewModel: SignupPhoneNumberViewModel
    
    // MARK: - Inits
    
    init(viewModel: SignupPhoneNumberViewModel){
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
    
    // MARK: - Methods
    
    override func layout() {
        view.addSubview(wellcomeLabel)
        
        let attrString = NSMutableAttributedString(string: wellcomeLabel.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        attrString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        
        wellcomeLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().inset(15)
        }
        
        wellcomeLabel.attributedText = attrString
        
        view.addSubview(securityLabel)
        
        securityLabel.snp.makeConstraints {
            $0.top.equalTo(wellcomeLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalTo(wellcomeLabel)
        }
        
        view.addSubview(phonenumberInputTextField)
        
        phonenumberInputTextField.snp.makeConstraints {
            $0.top.equalTo(securityLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalTo(wellcomeLabel)
            $0.height.equalTo(45)
        }
        
        view.addSubview(sendAuthMessageButton)
        
        sendAuthMessageButton.snp.makeConstraints {
            $0.top.equalTo(phonenumberInputTextField.snp.bottom).offset(15)
            $0.leading.trailing.equalTo(wellcomeLabel)
            $0.height.equalTo(45)
        }
    }
}
