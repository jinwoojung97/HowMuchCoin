//
//  ListViewModel.swift
//  Presentation
//
//  Created by inforex on 2022/10/20.
//

import Foundation

import Domain
import Util

import RxSwift

/// ViewModel OutPut 명시
protocol ListViewModelOutPut {
    var coinList: [Coin] { get }
    var didItemFetched: PublishSubject<Void> { get }
}

public final class ListViewModel: ListViewModelOutPut {

    private var fetchCoinListUseCase : FetchCoinListUseCase

    /// MARK: - OutPut
    var coinList : [Coin] = [] {
        didSet {
            self.didItemFetched.onNext(())
        }
    }
    var didItemFetched: PublishSubject<Void> = .init()

    public init(fetchCoinListUseCase: FetchCoinListUseCase){
        self.fetchCoinListUseCase = fetchCoinListUseCase
        
        fetchCoinList()
    }

    func fetchCoinList() {
        fetchCoinListUseCase.execute{[weak self] result in
            switch result {
            case .success(let list):
                Log.d(list)
                self?.coinList = list
            case .failure(let error):
                Log.e(error.localizedDescription)
            }
        }
    }
}
