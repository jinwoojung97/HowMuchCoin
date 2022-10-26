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
    let topSafeAreaView = UIView().then {
        $0.backgroundColor = .dynamicBackground
    }
    
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

    let entryView = EntryView().then {
        $0.backgroundColor = .dynamicGray
    }

    let rankingLabel = UILabel().then{
        $0.text = "순위"
        $0.font = .systemFont(ofSize: 13, weight: .bold)
        $0.textColor = .dynamicLabel
        $0.textAlignment = .center
    }

    let nameLabel = UILabel().then{
        $0.text = "종목"
        $0.font = .systemFont(ofSize: 13, weight: .bold)
        $0.textColor = .dynamicLabel
        $0.textAlignment = .left
    }

    let priceLabel = UILabel().then{
        $0.text = "가격(₩)"
        $0.font = .systemFont(ofSize: 13, weight: .bold)
        $0.textColor = .dynamicLabel
        $0.textAlignment = .right
    }

    let percentChangeLabel = UILabel().then{
        $0.text = "전일대비"
        $0.font = .systemFont(ofSize: 13, weight: .bold)
        $0.textColor = .dynamicLabel
        $0.textAlignment = .right
    }

    let optionLabel = UILabel().then{
        $0.text = "거래액(1D)"
        $0.font = .systemFont(ofSize: 13, weight: .bold)
        $0.textColor = .dynamicLabel
        $0.textAlignment = .right
    }

    let percentChangeSideMenuView = SideMenuView(frame: .zero, type: .percentChange).then{
        $0.isHidden = true
    }

    let optionSideMenuView = SideMenuView(frame: .zero, type: .option).then{
        $0.isHidden = true
    }

    lazy var listTableView = UITableView().then {
        $0.backgroundColor = .dynamicBackground
        $0.tableHeaderView = headerStackView
        $0.tableHeaderView?.frame.size.height = 90
        $0.separatorColor = .systemGray
        $0.register(CoinCell.self, forCellReuseIdentifier: CoinCell.identifier)
        $0.rowHeight = 44
        $0.dataSource = self
        $0.delegate = self
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .dynamicBackground
        initialize()
    }

    private func initialize(){
        addComponent()
        setConstraints()
        inputBind()
        outputBind()
    }
    
    private func addComponent(){
        [titleLabel, searchButton].forEach(titleWrapper.addSubview)

        searchWrapper.addSubview(searchTextField)

        entryWrapper.addSubview(entryView)
        entryView.rankView.addSubview(rankingLabel)
        entryView.nameView.addSubview(nameLabel)
        entryView.priceView.addSubview(priceLabel)
        entryView.percentChangeView.addSubview(percentChangeLabel)
        entryView.optionView.addSubview(optionLabel)

        [titleWrapper, searchWrapper, entryWrapper].forEach(headerStackView.addArrangedSubview)
        [listTableView, percentChangeSideMenuView, optionSideMenuView, topSafeAreaView].forEach(view.addSubview)
    }
    
    private func setConstraints(){
        topSafeAreaView.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }

        listTableView.snp.makeConstraints{
            $0.edges.equalTo(view.safeAreaLayoutGuide)
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
            $0.height.equalTo(30)
        }

        entryView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }

        [rankingLabel, nameLabel, priceLabel, percentChangeLabel, optionLabel].forEach{ label in
            label.snp.makeConstraints{
                $0.center.equalToSuperview()
            }
        }

        percentChangeSideMenuView.snp.makeConstraints{
            $0.top.equalTo(entryView.snp.bottom)
            $0.centerX.equalTo(percentChangeLabel)
            $0.width.equalTo(entryView.percentChangeView)
        }

        optionSideMenuView.snp.makeConstraints{
            $0.top.equalTo(entryView.snp.bottom)
            $0.centerX.equalTo(optionLabel)
            $0.width.equalTo(entryView.optionView)
        }
    }

    private func searchWrapperShowAndHide(){
        if searchWrapper.isHidden {
            searchWrapper.animShow()
        }else {
            searchWrapper.animHide()
        }
        listTableView.setAndLayoutTableHeaderView(header: headerStackView)
    }
}

// MARK: - Bind
extension ListViewController {
    /// Input
    private func inputBind() {
        searchButton.rx.tapGesture()
            .when(.recognized)
            .bind {[weak self] _ in
                self?.searchWrapperShowAndHide()
            }
            .disposed(by: disposeBag)
        
        percentChangeLabel.rx.tapGesture()
            .when(.recognized)
            .bind {[weak self] _ in
                guard let self = self else { return }
                self.percentChangeSideMenuView.isHidden = !self.percentChangeSideMenuView.isHidden
            }
            .disposed(by: disposeBag)

        optionLabel.rx.tapGesture()
            .when(.recognized)
            .bind {[weak self] _ in
                guard let self = self else { return }
                self.optionSideMenuView.isHidden = !self.optionSideMenuView.isHidden
            }
            .disposed(by: disposeBag)

        percentChangeSideMenuView.menuTapped.subscribe(onNext: {[weak self] menu in
            self?.percentChangeSideMenuView.isHidden = true
            self?.optionSideMenuView.isHidden = true
            self?.percentChangeLabel.text = menu.word
            self?.optionLabel.text = "거래액(1D)"
            self?.viewModel.sortList(sortBy: menu)
        }).disposed(by: disposeBag)

        optionSideMenuView.menuTapped.subscribe(onNext: {[weak self] menu in
            self?.percentChangeSideMenuView.isHidden = true
            self?.optionSideMenuView.isHidden = true
            self?.percentChangeLabel.text = "전일대비"
            self?.optionLabel.text = menu.word
            self?.viewModel.sortList(sortBy: menu)
        }).disposed(by: disposeBag)
    }

    /// OutPut
    private func outputBind() {
        viewModel.didItemFetched
            .subscribe {[weak self] _ in
                self?.listTableView.reloadData()
            }.disposed(by: disposeBag)
    }
}

// MARK: -TableView
extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.coinList.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = listTableView.dequeueReusableCell(withIdentifier: CoinCell.identifier) as? CoinCell else { return UITableViewCell() }

        cell.dataBind(coin: viewModel.coinList[indexPath.row],
                      sortBy: viewModel.sortBy)
        cell.rankingLabel.text = "\(indexPath.row + 1)"

        return cell
    }
}
