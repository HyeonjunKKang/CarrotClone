//
//  EditProfileViewModel.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/07/31.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

enum EditType {
    case new
    case edit
}

enum editProfileNavigation {
    case finish
}

final class EditProfileViewModel: ViewModel {
    
    struct Input {
        let imageViewButtonTapped: Observable<Void>
        let completeButtonTapped: Observable<Void>
        let selectedProfileImage: Observable<UIImage>
        let name: Observable<String>
    }
    
    struct Output {
        let type: Observable<EditType>
        let actionSheetAlert: Signal<Alert>
        let showImagePicker: Signal<Void>
        let image: Driver<UIImage>
        let name: Driver<String>
    }
    
    var disposeBag = DisposeBag()
    var type = BehaviorSubject<EditType>(value: .new)
    let navigation = PublishSubject<editProfileNavigation>()
    private let actionSheetAlert = PublishSubject<Alert>()
    private let showImagePicker = PublishSubject<Void>()
    private let image = BehaviorSubject<UIImage>(value: UIImage())
    private let name = BehaviorSubject<String>(value: "Default")
    
    var editProfileUseCase: EditProfileUseCaseProtocol?
    
    
    func transform(input: Input) -> Output {
        
        bindImage(input: input)
        bindScene(input: input)
        
        
//        type
//            .filter { $0 == .edit }
//            .withUnretained(self)
////            .flatMap

        // TODO: - 프로필 기존에 있으면 데이터 불러오기
        
        let photoSelectAlertObserver = PublishSubject<Void>()
        
        input.imageViewButtonTapped
            .map { _ in
                return Alert(title: "이미지 선택", message: "앨범에서 이미지를 선택하시겠습니까?", observer: photoSelectAlertObserver.asObserver())
            }
            .withUnretained(self)
            .subscribe(onNext: { viewModel, alert in
                viewModel.actionSheetAlert.onNext(alert)
            })
            .disposed(by: disposeBag)
        
        photoSelectAlertObserver
            .map { _ in () }
            .bind(to: showImagePicker)
            .disposed(by: disposeBag)
        
        input.name
            .bind(to: name)
            .disposed(by: disposeBag)
        
        return Output(
            type: type.asObserver(),
            actionSheetAlert: actionSheetAlert.asSignal(onErrorSignalWith: .empty()),
            showImagePicker: showImagePicker.asSignal(onErrorSignalWith: .empty()),
            image: image.asDriver(onErrorJustReturn: UIImage(systemName: "person") ?? UIImage()),
            name: name.asDriver(onErrorJustReturn: "Default")
        )
    }
    
    private func bindImage(input: Input) {
        Observable.merge(
            input.selectedProfileImage
        )
        .bind(to: image)
        .disposed(by: disposeBag)
    }
    
    private func bindScene(input: Input) {

        input
            .completeButtonTapped
            .withLatestFrom(type)
            .filter { $0 == .new }
            .withLatestFrom( Observable.combineLatest(input.name, image) )
            .flatMap { [weak self] in
                self?.editProfileUseCase?.editProfile(name: $0.0, image: $0.1) ?? .empty()
            }
            .map { .finish }
            .bind(to: navigation)
            .disposed(by: disposeBag)
        
    }
}
