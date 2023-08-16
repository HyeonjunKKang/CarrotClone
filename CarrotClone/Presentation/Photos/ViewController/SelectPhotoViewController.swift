//
//  SelectPhotoViewController.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/08/10.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then
import Photos

final class SelectPhotoViewController: ViewController {
    
    // MARK: - Compoenets
    
    enum Constraint {
        static let cellWidth = (UIScreen.main.bounds.width - 6) / 3
    }
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 3
        layout.minimumInteritemSpacing = 3
        layout.itemSize = CGSize(width: SelectPhotoViewController.Constraint.cellWidth , height: SelectPhotoViewController.Constraint.cellWidth )
        
        $0.collectionViewLayout = layout
        $0.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
    }

    private let rightButton = UIButton().then {
        $0.setTitle("완료", for: .normal)
        $0.setTitleColor(UIColor.carrotColor.carrot1, for: .normal)
    }
    
    // MARK: - Properties
    
    let viewModel: SelectPhotoViewModel
    
    // MARK: - Inits
    
    init(viewModel: SelectPhotoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "사진선택"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
    }
    
    // MARK: - Bind
    
    override func bind() {
        
        let input = SelectPhotoViewModel.Input(
            viewDidLoad: rx.viewWillAppear.map{ _ in }.asObservable().take(1),
            selectedPhoto: collectionView.rx.modelSelected(Photo.self)
                .throttle(.seconds(1), scheduler: MainScheduler.asyncInstance),
            completionButtonTapped: rightButton.rx.tap
                .throttle(.seconds(1), scheduler: MainScheduler.asyncInstance),
            backButtonTapped: backButton.rx.tap
                .throttle(.seconds(1), scheduler: MainScheduler.asyncInstance)
        )
        
        let output = viewModel.transform(input: input)
        
        output.asset
            .drive(collectionView.rx.items) { collectionView, index, item in
                guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: PhotoCollectionViewCell.identifier,
                        for: IndexPath(row: index, section: 0)) as? PhotoCollectionViewCell else {
                    return UICollectionViewCell()
                }
                
                cell.configure(photo: item)
                
                return cell
            }
            .disposed(by: disposeBag)
        
        output.buttonEnable
            .bind(to: rightButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.buttonEnable
            .subscribe(onNext: { [weak self] in
                if !$0 {
                    self?.rightButton.setTitleColor(UIColor.gray, for: .normal)
                } else {
                    self?.rightButton.setTitleColor(UIColor.carrotColor.carrot1, for: .normal)
                }
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Layout
    
    override func layout() {

        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
