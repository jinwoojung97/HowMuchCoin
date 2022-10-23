//
//  ListViewController.swift
//  Presentation
//
//  Created by inforex on 2022/10/18.
//

import Foundation
import UIKit

import Util

import RxSwift
import RxGesture
import Then
import SnapKit

public final class ListViewController: UIViewController {
    var coordinator: ListCoordinator?
    let disposeBag = DisposeBag()
    private var viewModel : ListViewModel!

    /// ViewController 의존성 주입을 위한 Create 함수
    public static func create(viewModel: ListViewModel)-> ListViewController {
        let vc = ListViewController()
        vc.viewModel = viewModel

        return vc
    }

    // MARK: - Components
    let headerStackView = UIStackView().then {
        $0.backgroundColor = .white
        $0.axis = .vertical
    }

    let titleWrapper = UIView().then {
        $0.backgroundColor = .dynamicBackground
    }

    let titleLabel = UILabel().then {
        $0.text = "실시간 TOP 100"
        $0.textColor = .dynamicLabel
        $0.font = .systemFont(ofSize: 32, weight: .bold)
    }
    
    let searchButton = UIButton().then {
        $0.roundCorners(.allCorners, radius: 25)
        $0.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
    }

    let searchWrapper = UIView().then {
        $0.backgroundColor = .dynamicBackground
        $0.isHidden = true
    }

    let searchTextField = UITextField().then{
        $0.backgroundColor = .dynamicGray
        $0.font = .systemFont(ofSize: 15, weight: .regular)
        $0.textColor = .dynamicLabel
        $0.placeholder = "종목을 검색하세요."
        $0.roundCorners(.allCorners, radius: 8)
        $0.addLeftPadding()
    }

    let entryWrapper = UIView().then {
        $0.backgroundColor = .dynamicBackground
    }
    
    let entryLabel = UILabel().then{
        $0.text = "항목이 들어갈 곳"
        $0.font = .systemFont(ofSize: 15, weight: .regular)
        $0.textColor = .dynamicLabel
    }

    lazy var listTableView = UITableView().then {
        $0.backgroundColor = .dynamicBackground
        $0.tableHeaderView = headerStackView
        $0.tableHeaderView?.frame.size.height = 90
        $0.separatorColor = .systemGray
//        $0.register(BookmarkCell.self, forCellReuseIdentifier: BookmarkCell.identifier)
        $0.dataSource = self
        $0.delegate = self
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        initialize()
    }
    
    func initialize(){
        addComponent()
        setConstraints()
        bind()
    }
    
    func addComponent(){
        [titleLabel, searchButton].forEach(titleWrapper.addSubview)
        searchWrapper.addSubview(searchTextField)
        [entryLabel].forEach(entryWrapper.addSubview)
        [titleWrapper, searchWrapper, entryWrapper].forEach(headerStackView.addArrangedSubview)
        [listTableView].forEach(view.addSubview)
    }
    
    func setConstraints(){
        listTableView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }

        titleLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(12)
        }
        
        searchButton.snp.makeConstraints{
            $0.size.equalTo(50)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12)
        }

        titleWrapper.snp.makeConstraints{
            $0.height.equalTo(50)
        }

        searchWrapper.snp.makeConstraints{
            $0.height.equalTo(40)
        }

        searchTextField.snp.makeConstraints{
            $0.top.bottom.equalToSuperview().inset(5)
            $0.leading.trailing.equalToSuperview().inset(12)
        }

        entryWrapper.snp.makeConstraints{
            $0.height.equalTo(40)
        }
        
        entryLabel.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
    }
    
    func bind() {
        searchButton.rx.tapGesture()
            .when(.recognized)
            .bind {[weak self] _ in
                self?.searchWrapperShowAndHide()
            }
            .disposed(by: disposeBag)
    }
    
    func searchWrapperShowAndHide(){
        if searchWrapper.isHidden {
            searchWrapper.animShow()
        }else {
            searchWrapper.animHide()
        }
        listTableView.setAndLayoutTableHeaderView(header: headerStackView)
    }
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.dynamicBackground
        cell.selectionStyle = .none

        return cell
    }
}
