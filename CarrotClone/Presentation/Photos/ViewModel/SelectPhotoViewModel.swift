//
//  SelectPhotoViewModel.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/08/10.
//

import UIKit
import RxSwift
import RxCocoa

enum SelectPhotoNavigation {
    case back
    case finish(image: [UIImage])
}

final class SelectPhotoViewModel: ViewModel {
    
    struct Input {
        let viewDidLoad: Observable<Void>
        let selectedPhoto: Observable<Photo>
        let completionButtonTapped: Observable<Void>
        let backButtonTapped: Observable<Void>
    }
    
    struct Output {
        let asset: Driver<[Photo]>
        let buttonEnable: Observable<Bool>
    }
    
    private let photo = BehaviorSubject<[Photo]>(value: [])
    private let buttonEnable = PublishSubject<Bool>()
    let navigation = PublishSubject<SelectPhotoNavigation>()
    
    var selectPhotoUseCase: SelectPhotoUseCaseProtocol?
    var disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        
        input.viewDidLoad
            .withUnretained(self)
            .flatMap { $0.0.selectPhotoUseCase?.fetchPhoto() ?? .empty()}
            .bind(to: photo)
            .disposed(by: disposeBag)
        
        input.selectedPhoto
            .withLatestFrom(photo) { selected, photos in
                
                var updatedPhotos = photos
                if let selectedIndex = updatedPhotos.firstIndex(where: { $0.identifier == selected.identifier }) {
                    
                    if updatedPhotos[selectedIndex].checked {
                        // 이미 체크된 셀을 클릭한 경우
                        updatedPhotos[selectedIndex].checked = false
                        // checkedNumber를 조정해야 함
                        let currentCheckedNumber = updatedPhotos[selectedIndex].checkedNumber
                        
                        for index in 0..<updatedPhotos.count {
                            if updatedPhotos[index].checked && currentCheckedNumber < updatedPhotos[index].checkedNumber {
                                updatedPhotos[index].checkedNumber -= 1
                            }
                        }
                        updatedPhotos[selectedIndex].checkedNumber = 0
                        
                    } else {
                        // 체크되지 않은 셀을 클릭한 경우
                        updatedPhotos[selectedIndex].checked = true
                        // checkedNumber를 조정해야 함
                        var nextCheckedNumber = 0
                        for index in 0..<updatedPhotos.count {
                            if updatedPhotos[index].checked {
                                nextCheckedNumber += 1
                            }
                        }
                        updatedPhotos[selectedIndex].checkedNumber = nextCheckedNumber
                    }
                }
                return updatedPhotos
            }
            .bind(to: photo)
            .disposed(by: disposeBag)
        
        photo
            .map { $0.filter { $0.checked == true }}
            .map {
                !$0.isEmpty
            }
            .bind(to: buttonEnable)
            .disposed(by: disposeBag)
        
        input.completionButtonTapped
            .withLatestFrom(photo)
            .map { $0.filter { $0.checked == true} }
            .map { $0.sorted { $0.checkedNumber < $1.checkedNumber } }
            .map { $0.map { $0.image } }
            .withUnretained(self)
            .subscribe(onNext: { viewModel, filterdPhoto in
                viewModel.navigation.onNext(.finish(image: filterdPhoto))
            })
            .disposed(by: disposeBag)
        
        input.backButtonTapped
            .map { .back }
            .bind(to: navigation)
            .disposed(by: disposeBag)
        
        return Output(
            asset: photo.asDriver(onErrorJustReturn: []),
            buttonEnable: buttonEnable
        )
    }
}
