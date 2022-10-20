//
//  CoinListRepository.swift
//  Repository
//
//  Created by inforex on 2022/10/20.
//

import Foundation

import Domain
import Util

public final class CoinRepository: CoinRepositoryProtocol {

    public init() {}
    /// 코인리스트 가져오기
    public func fetchCoinList(completion: @escaping (Result<[Coin], Error>) -> Void) {
        CoinAPI.reqFetchCoinList{ completion($0) }
    }
}
