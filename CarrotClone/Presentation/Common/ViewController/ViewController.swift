//
//  ViewController.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/07/05.
//

import UIKit
import RxSwift
import Then

class ViewController: UIViewController {
            
    var disposeBag = DisposeBag()
    
    let backButton = UIButton().then {
        $0.tintColor = .black
        $0.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        layout()
        bind()
    }
    
    func layout() {}
    func bind() {}
}
