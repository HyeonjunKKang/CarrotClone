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
import Then

final class HomeViewController: ViewController {
    
    // MARK: - Properties
    
    private let tableView = UITableView()
    let viewModel: HomeViewModel
    
    private let writeButton = UIButton().then {
        $0.backgroundColor = .orange
        $0.setTitle("+ 글쓰기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        $0.layer.cornerRadius = 23
        $0.layer.masksToBounds = false
        $0.layer.shadowRadius = 3
        $0.layer.shadowOpacity = 0.05
    }

    
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

        setLeftButton()
        setRightButtons()
        
        
    }

    
    // MARK: - functions
    
    func chevronButtonTapped() {
        print("동네 선택 팝업")
    }

    func setLeftButton() {
        let titleLabel = UILabel()
        titleLabel.text = "상현 2동"
        titleLabel.font = UIFont.systemFont(ofSize: 17.0, weight: .bold)
        titleLabel.textColor = .black
        
        let chevronButton = UIButton(type: .system)
        chevronButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        chevronButton.tintColor = .black
        
        let titleStackView = UIStackView(arrangedSubviews: [titleLabel, chevronButton])
        titleStackView.axis = .horizontal
        titleStackView.spacing = 8
        
        let titleView = UIView()
        titleView.addSubview(titleStackView)
        titleStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
        }
        
        navigationItem.titleView = titleView
        
        chevronButton.rx.tap
            .subscribe(onNext: chevronButtonTapped)
            .disposed(by: disposeBag)
    }


    func setRightButtons() {
        let listButton = createBarButton(imageName: "line.3.horizontal") {
            print("리스트 버튼")
        }
        let searchButton = createBarButton(imageName: "magnifyingglass") {
            print("검색 버튼")
        }
        let alarmButton = createBarButton(imageName: "bell") {
            print("알람 버튼")
        }

        navigationItem.rightBarButtonItems = [alarmButton, searchButton, listButton]
    }

    private func createBarButton(imageName: String, action: @escaping () -> Void) -> UIBarButtonItem {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: imageName), for: .normal)
        button.tintColor = UIColor.black
        button.rx.tap
            .subscribe(onNext: { _ in
                action()
            })
            .disposed(by: disposeBag)
        return UIBarButtonItem(customView: button)
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
        
        [tableView, writeButton]
            .forEach { view.addSubview($0) }

        tableView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
        
        writeButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-10)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
            $0.size.equalTo(CGSize(width: 99, height: 46))
        }
    }

}

// MARK: - Extension

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
