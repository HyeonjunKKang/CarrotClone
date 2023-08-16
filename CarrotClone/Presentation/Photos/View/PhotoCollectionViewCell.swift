//
//  PhotoCollectionViewCell.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/08/10.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

final class PhotoCollectionViewCell: UICollectionViewCell, Identifiable {
    
    // MARK: - Compoenents
    
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleToFill
    }
    
    private let selectedNumberView = SelectNumberView().then { _ in
        
    }
    
    // MARK: - Properties
    
    private let photo = BehaviorSubject<Photo?>(value: nil)
    private let disposeBag = DisposeBag()
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Bind
    
    func bind() {
        photo
            .compactMap { $0 }
            .map { $0.image }
            .bind(to: imageView.rx.image)
            .disposed(by: disposeBag)
    
        
        photo
            .filter { $0?.identifier != "camera" }
            .compactMap { $0 }
            .bind(to: selectedNumberView.rx.select)
            .disposed(by: disposeBag)
        
        photo
            .compactMap { $0 }
            .bind(to: rx.selected)
            .disposed(by: disposeBag)
    }
    
    func configure(photo: Photo) {
        self.photo.onNext(photo)
    }
    
    // MARK: - Layout
    
    func layout() {
        backgroundColor = .white
        
        addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.addSubview(selectedNumberView)
        
        selectedNumberView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().inset(10)
            $0.height.width.equalTo(20)
        }
    }
}
