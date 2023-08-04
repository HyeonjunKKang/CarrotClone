//
//  BoardViewModel.swift
//  CarrotClone
//
//  Created by juyeong koh on 2023/08/03.
//

import UIKit
import RxSwift
import RxCocoa

final class BoardViewModel: ViewModel {

    struct Input {
    }
    struct Output {
    }
    
    var disposeBag = DisposeBag()
    
    init() {

    }
    
    func transform(input: Input) -> Output {
        return Output()
    }
    
}
