//
//  ViewController.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/07/06.
//

import UIKit
import RxSwift
import RxCocoa

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
    }
    
    override func layout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
    }
    
    public func binding(_ viewModel: HomeViewModel) {
        viewModel.getCellData().bind(to: tableView.rx.items) { (tableView: UITableView, index: Int, element: String) -> UITableViewCell in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewCell.reuseIdentifier) as? HomeViewCell else { fatalError() }
            
            cell.setUpData(element)
            return cell
            
        }
        .disposed(by: disposeBag)
    }
    
}
