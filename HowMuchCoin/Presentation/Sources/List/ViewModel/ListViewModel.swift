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
/// ViewModel InPut 명시
protocol ListViewModelInput {
    func sortList(sortBy: SortBy)
    func searchList(word: String)
}

public final class ListViewModel: ListViewModelOutPut {

    private var fetchCoinListUseCase : FetchCoinListUseCase

    /// MARK: - OutPut
    var coinList : [Coin] = [] {
        didSet {
            self.didItemFetched.onNext(())
        }
    }
    var originalCoinList: [Coin] = [] // API에서 불러온 원본 리스트
    var didItemFetched: PublishSubject<Void> = .init()
    var sortBy : SortBy = .initialState

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
                self?.originalCoinList = list
            case .failure(let error):
                Log.e(error.localizedDescription)
            }
        }
    }
}

//MARK: - INPUT. View event methods
extension ListViewModel: ListViewModelInput{
    /// 정렬 기준에 따라 리스트 정렬
    func sortList(sortBy: SortBy) {
        self.sortBy = sortBy
        switch sortBy{
        case .initialState: // 초기 상태
            break
        case .percentChange1HAsc: // 전시간대비- (오름차순)
            coinList.sort(by: {$0.quotes.priceInfo.percentChange1h < $1.quotes.priceInfo.percentChange1h})
        case .percentChange1HDesc: // 전시간대비+ (내림차순)
            coinList.sort(by: {$0.quotes.priceInfo.percentChange1h > $1.quotes.priceInfo.percentChange1h})
        case .percentChange24HAsc: // 전일대비- (오름차순)
            coinList.sort(by: {$0.quotes.priceInfo.percentChange24h < $1.quotes.priceInfo.percentChange24h})
        case .percentChange24HDesc: // 전일대비+ (내림차순)
            coinList.sort(by: {$0.quotes.priceInfo.percentChange24h > $1.quotes.priceInfo.percentChange24h})
        case .percentChange7DAsc: // 전주대비- (오름차순)
            coinList.sort(by: {$0.quotes.priceInfo.percentChange7d < $1.quotes.priceInfo.percentChange7d})
        case .percentChange7DDesc: // 전주대비+ (내림차순)
            coinList.sort(by: {$0.quotes.priceInfo.percentChange7d > $1.quotes.priceInfo.percentChange7d})
        case .marketCapAsc: // 총 시가- (오름차순)
            coinList.sort(by: {$0.quotes.priceInfo.marketCap < $1.quotes.priceInfo.marketCap})
        case .marketCapDesc: // 총 시가+ (내림차순)
            coinList.sort(by: {$0.quotes.priceInfo.marketCap > $1.quotes.priceInfo.marketCap})
        case .volume24HAsc: // 거래액(1D)- (오름차순)
            coinList.sort(by: {$0.quotes.priceInfo.volume24h < $1.quotes.priceInfo.volume24h})
        case .volume24HDesc: // 거래액(1D)+ (내림차순)
            coinList.sort(by: {$0.quotes.priceInfo.volume24h > $1.quotes.priceInfo.volume24h})
        }
    }

    /// 검색어가 포함된 코인리스트
    func searchList(word: String) {
        Log.d(word)
        if word.isEmpty {
            coinList = originalCoinList // 다시 원본 데이터로
        } else {
            coinList = originalCoinList.filter{ coin in
                coin.name.lowercased().contains(word.lowercased())
            }
        }
        sortList(sortBy: sortBy) // 정렬 기준에 따라 다시 정렬
    }
}
