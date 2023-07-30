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
        let dummy: Driver<[String]>
    }
    
    func transform(input: Input) -> Output {
        input.viewDidLoad.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.behaviorSubject.onNext(self.items)
        } )

        return Output(dummy: behaviorSubject.asDriver(onErrorJustReturn: []))
    }
    
    // MARK: - Properties
    
    var behaviorSubject = BehaviorSubject<[String]>(value: [])
    var disposeBag = DisposeBag()
    var items = ["아이폰", "맥북", "아이패드"]

    // MARK: - Init
    
    init() {

    }
    
    // MARK: - Helpers
    
}


