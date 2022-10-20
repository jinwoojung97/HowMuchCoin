//
//  CoinRepositoryProtocol.swift
//  DomainTests
//
//  Created by inforex on 2022/10/20.
//

import Foundation

public protocol CoinRepositoryProtocol {
    func fetchCoinList(completion: @escaping ([Coin]) -> Void)
}
