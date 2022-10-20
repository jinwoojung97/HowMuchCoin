//
//  RequestCoinListUseCase.swift
//  DomainTests
//
//  Created by inforex on 2022/10/20.
//

import Foundation

public protocol FetchCoinListUseCase {
    func execute(completion: @escaping (Result<[Coin], Error>) -> Void)
}

public final class DefaultFetchCoinListUseCase: FetchCoinListUseCase {
    private let coinRepository: CoinRepositoryProtocol

    public init(coinRepository: CoinRepositoryProtocol){
        self.coinRepository = coinRepository
    }

    public func execute(completion: @escaping (Result<[Coin], Error>) -> Void) {
        coinRepository.fetchCoinList{ completion($0) }
    }
}
