//
//  ViewController.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/07/06.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class HomeViewController: ViewController {
    
    // MARK: - Properties
    
    private let tableView = UITableView()
    let viewModel: HomeViewModel
    
    // MARK: - Init
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    
    // MARK: - Binding
    
    
    override func bind() {
        tableView.register(HomeViewCell.self, forCellReuseIdentifier: HomeViewCell.reuseIdentifier)
        tableView.rowHeight = 100
        
        //        viewModel.getCellData().bind(to: tableView.rx.items) { (tableView: UITableView, index: Int, element: String) -> UITableViewCell in
        //            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewCell.reuseIdentifier) as? HomeViewCell else { fatalError() }
        //
        //            cell.setUpData(element)
        //            return cell
        //        }
        //        .disposed(by: disposeBag)
        
        let input = HomeViewModel.Input(viewDidLoad: rx.viewWillAppear.map { _ in })
        let output = viewModel.transform(input: input)

//        output.dummy.drive(tableView.rx.items) { (tableView: UITableView, index: Int, element: String) -> UITableViewCell in
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewCell.reuseIdentifier) as? HomeViewCell else { fatalError() }
//
//            cell.setUpData(element)
//            return cell
        
        output.dummy
            .drive(tableView.rx.items(cellIdentifier: HomeViewCell.reuseIdentifier, cellType: HomeViewCell.self)) { (_, element, cell) in
                 cell.titleLabel.text = element.title
                 cell.subtitleLabel.text = element.subtitle
                 cell.priceLabel.text = element.price
                 cell.titleImage.image = element.image
             }
             .disposed(by: disposeBag)
     }
        
    
        
    
    
    override func layout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
    }

}


extension Reactive where Base: UIViewController{
    var viewDidLoad: ControlEvent<Void> {
        let source = self.methodInvoked(#selector(Base.viewDidLoad)).map { _ in }
        return ControlEvent(events: source)
    }
    var viewWillAppear: ControlEvent<Bool> {
            let source = self.methodInvoked(#selector(Base.viewWillAppear)).map { $0.first as? Bool ?? false }
            return ControlEvent(events: source)
        }
}
