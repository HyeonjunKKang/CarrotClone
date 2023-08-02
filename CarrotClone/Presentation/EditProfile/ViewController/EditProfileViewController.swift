//
//  EditProfileViewController.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/07/31.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

final class EditProfileViewController: ViewController {
    
    // MARK: - Components
    
    private let profileImageView = ProfileImageView(frame: .zero)
    
    private let nicknameLabel = UILabel().then {
        $0.text = "닉네임"
        $0.font = .systemFont(ofSize: 14, weight: .semibold)
    }
    
    private let nicknameTextField = UITextField().then {
        $0.placeholder = "닉네임을 입력해주세요."
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        $0.leftViewMode = .always
        $0.layer.cornerRadius = 3
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.carrotColor.lightgray1?.cgColor
    }

    private let annotationLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13)
    }
    
    private let rightButton = UIButton().then {
        $0.setTitle("완료", for: .normal)
    }
        
    // MARK: - Properties
    
    let viewModel: EditProfileViewModel
    private let selectedProfileImage = PublishRelay<UIImage>()
    private var imagePicker: UIImagePickerController?
    
    // MARK: - Initializer
    
    init(viewModel: EditProfileViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
        
        configurePicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        title = "프로필 설정"
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - Bind
    
    override func bind() {
        
        let input = EditProfileViewModel.Input(
            imageViewButtonTapped: profileImageView.button.rx.tap
                .throttle(.seconds(1), scheduler: MainScheduler.asyncInstance),
            completeButtonTapped: rightButton.rx.tap
                .throttle(.seconds(1), scheduler: MainScheduler.asyncInstance),
            selectedProfileImage: selectedProfileImage.asObservable(),
            name: nicknameTextField.rx.text.orEmpty.asObservable()
        )
        
        let output = viewModel.transform(input: input)
        
        output.type
            .subscribe(onNext: { [weak self] in
                switch $0 {
                case .new:
                    self?.backButton.isHidden = true
                    self?.backButton.isEnabled = false
                case .edit:
                    break
                }
            })
            .disposed(by: disposeBag)
        
        output.actionSheetAlert
            .emit(to: rx.presentActionSheet)
            .disposed(by: disposeBag)
        
        output.showImagePicker
            .emit(onNext: { [weak self] _ in
                self?.presentPicker()
            })
            .disposed(by: disposeBag)
        
        output.image
            .drive(profileImageView.imageView.rx.image)
            .disposed(by: disposeBag)
        
        output.name
            .drive(nicknameTextField.rx.text)
            .disposed(by: disposeBag)
        
        bindAnnotaion()
    }
    
    func bindAnnotaion() {
        nicknameTextField.rx.text
            .subscribe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] string in
                guard let self = self else { return }
                
                self.annotationLabel.textColor = .red
                self.rightButton.isEnabled = false
                self.rightButton.setTitleColor(.lightGray, for: .normal)
                
                if string?.count == 0 {
                    self.annotationLabel.text = "닉네임을 입력해주세요"
                } else if string?.count == 1 {
                    self.annotationLabel.text = "닉네임은 2글자 이상 입력해주세요"
                } else {
                    self.annotationLabel.text = "사용 가능합니다."
                    self.annotationLabel.textColor = .blue
                    
                    self.rightButton.isEnabled = true
                    self.rightButton.setTitleColor(.black, for: .normal)
                }
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Layout
    
    override func layout() {
        view.addSubview(profileImageView)
        
        profileImageView.snp.makeConstraints {
            $0.height.width.equalTo(120)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            $0.centerX.equalToSuperview()
        }
        
        view.addSubview(nicknameLabel)
        
        nicknameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        view.addSubview(nicknameTextField)
        
        nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(nicknameLabel)
            $0.height.equalTo(60)
        }
        
        view.addSubview(annotationLabel)
        
        annotationLabel.snp.makeConstraints {
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(nicknameTextField)
        }
    }
    
    // MARK: - Methods
}

extension EditProfileViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    private func configurePicker() {
        imagePicker = UIImagePickerController()
        imagePicker?.delegate = self
        imagePicker?.sourceType = .photoLibrary
        imagePicker?.allowsEditing = true
    }
    
    private func presentPicker() {
        guard let imagePicker else { return }
        present(imagePicker, animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var newImage: UIImage?

        if let possibleImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            newImage = possibleImage
        }
        
        if let image = newImage {
            selectedProfileImage.accept(image)
        }
        
        self.dismiss(animated: true)
    }
}
