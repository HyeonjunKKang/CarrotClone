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
        let item1 = ItemModel(title: "아이폰", subtitle: "상현2동", price: "100만원", image: UIImage(named: "titleImage")!)
        let item2 = ItemModel(title: "맥북", subtitle: "성복동", price: "200만원", image: UIImage(named: "titleImage")!)
        let item3 = ItemModel(title: "아이패드", subtitle: "성복동", price: "150만원", image: UIImage(named: "titleImage")!)

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


