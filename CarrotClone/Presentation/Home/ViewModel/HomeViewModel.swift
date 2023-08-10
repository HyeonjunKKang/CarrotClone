//
//  ViewModel.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/07/06.
//

import RxSwift
import UIKit
import RxCocoa

class HomeViewModel: ViewModel {
    
    struct Input {
        let viewDidLoad: Observable<Void>
    }
    struct Output {
        let dummy: Driver<[ItemModel]>
    }
    
    // MARK: - Properties
    
    weak var coordinator: HomeCoordinator?
    
    var behaviorSubject = BehaviorSubject<[ItemModel]>(value: [])
    var disposeBag = DisposeBag()
    
    private var itemModels: [ItemModel] = []
    
//    var navigationTitleRelay = BehaviorRelay<String>(value: "지역 이름")

    // MARK: - Init
    
    init() {

    }
    
    // MARK: - Selectors


    
    // MARK: - Helpers

    
    private func updateData() {
        
        // dummy data
        let item1 = ItemModel(title: "아이폰", place: "상현2동", postTime: 1, price: 10000, postImage: UIImage(named: "titleImage")!, heart: 2)
        let item2 = ItemModel(title: "아이패드", place: "성복동", postTime: 15, price: 20000, postImage: UIImage(named: "titleImage")!, heart: 3)
        let item3 = ItemModel(title: "애플워치", place: "풍덕천동", postTime: 20, price: 2000, postImage: UIImage(named: "titleImage")!, heart: 1)
        

        itemModels = [item1, item2, item3]

        let data = itemModels
        behaviorSubject.onNext(data)
    }
    

    func transform(input: Input) -> Output {
        input.viewDidLoad.subscribe(onNext: { [weak self] _ in
            self?.updateData()
        })
        .disposed(by: disposeBag)

        return Output(dummy: behaviorSubject.asDriver(onErrorJustReturn: []))
    }
    
}


