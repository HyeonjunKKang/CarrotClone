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
    
    var behaviorSubject = BehaviorSubject<[ItemModel]>(value: [])
    var disposeBag = DisposeBag()
    
    private var itemModels: [ItemModel] = []

    // MARK: - Init
    
    init() {


    }
    
    // MARK: - Helpers
    
    private func updateData() {
        
        // dummy data
        let item1 = ItemModel(title: "아이폰", subtitle: "스마트폰", price: "100만원", image: UIImage(named: "titleImage")!)
        let item2 = ItemModel(title: "맥북", subtitle: "노트북", price: "200만원", image: UIImage(named: "titleImage")!)
        let item3 = ItemModel(title: "아이패드", subtitle: "태블릿", price: "150만원", image: UIImage(named: "titleImage")!)

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


