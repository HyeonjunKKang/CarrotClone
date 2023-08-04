//
//  BoardViewController.swift
//  CarrotClone
//
//  Created by juyeong koh on 2023/08/03.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

final class BoardViewController: ViewController {
    
    // MARK: - Properties
    
    private let scrollView = UIScrollView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
        $0.showsVerticalScrollIndicator = true
    }
    
    private let contentView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .purple
    }
    
    lazy var titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .bold)
        $0.textColor = .black
        $0.text = "제목"
    }
    
    lazy var titleTextField = UITextField().then {
        $0.borderStyle = .roundedRect
        $0.attributedPlaceholder = NSAttributedString(string: "제목", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        $0.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    lazy var priceLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .bold)
        $0.textColor = .black
        $0.text = "가격"
    }
    
    lazy var priceTextField = UITextField().then {
        $0.borderStyle = .roundedRect
        $0.attributedPlaceholder = NSAttributedString(string: "￦ 가격을 입력해주세요.", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        $0.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    lazy var explainLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .bold)
        $0.textColor = .black
        $0.text = "자세한 설명"
    }
    
    lazy var explainTextView = UITextView().then {
        $0.layer.borderWidth = 0.5
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
        $0.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        $0.layer.borderColor =  UIColor(red: 0.87, green: 0.87, blue: 0.88, alpha: 1.00).cgColor
        $0.attributedText = NSAttributedString(string: """
                                                올릴 게시글 내용을 작성해주세요. (판매금지 물품은 게시가 제한될 수 있어요.)\n\n신뢰할 수 있는 거래를 위해 자세히 적어주세요.\n과학기술정보통신부, 한국 인터넷진흥원과 함께 해요.
                                                """,
                                                attributes: [
                                                    NSAttributedString.Key.foregroundColor: UIColor(red: 0.54, green: 0.56, blue: 0.58, alpha: 1.00).cgColor,
                                                    NSAttributedString.Key.paragraphStyle: {
                                                        let style = NSMutableParagraphStyle()
                                                        style.alignment = .left
                                                        style.lineSpacing = 4
                                                        return style
                                                    }()
                                                ])
        $0.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    lazy var completeButton = UIButton().then {
        $0.layer.cornerRadius = 7
        $0.clipsToBounds = true
        $0.backgroundColor = .orange
        $0.setTitle("작성 완료", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
    }


    // MARK: - Init
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUIConstraints()
        navigationItem.title = "내 물건 팔기"
    }
    
    // MARK: - Functions
    
    private func setUpUIConstraints() {
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
    
    
    // MARK: - Binding
    
    override func bind() {
        
    }
    
    // MARK: - Layout
    
    override func layout() {
        
        view.addSubview(scrollView)
        
        [contentView, titleLabel, titleTextField, priceLabel, priceTextField, explainLabel, explainTextView, completeButton]
            .forEach { scrollView.addSubview($0) }
        
        scrollView.snp.makeConstraints {
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.leading.trailing.equalTo(scrollView)
            $0.top.equalTo(scrollView).offset(10)
            $0.bottom.equalTo(scrollView).offset(-10)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(scrollView).offset(100)
            $0.leading.equalTo(scrollView).offset(20)
            $0.trailing.equalTo(scrollView).offset(-20)
        }
        
        titleTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalTo(titleLabel)
            $0.height.equalTo(40)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom).offset(30)
            $0.leading.equalTo(titleTextField)
            $0.trailing.equalTo(titleTextField)
        }
        
        priceTextField.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).offset(10)
            $0.leading.equalTo(priceLabel)
            $0.trailing.equalTo(priceLabel)
            $0.height.equalTo(40)
        }
        
        explainLabel.snp.makeConstraints {
            $0.top.equalTo(priceTextField.snp.bottom).offset(20)
            $0.leading.equalTo(priceTextField)
            $0.trailing.equalTo(priceTextField)
        }
        
        explainTextView.snp.makeConstraints {
            $0.top.equalTo(explainLabel.snp.bottom).offset(10)
            $0.leading.equalTo(explainLabel)
            $0.trailing.equalTo(explainLabel)
            $0.height.equalTo(150)
        }
        
        completeButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            $0.height.equalTo(50)
        }
        
    }

}
