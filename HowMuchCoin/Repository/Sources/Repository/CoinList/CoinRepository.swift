//
//  CoinListRepository.swift
//  Repository
//
//  Created by inforex on 2022/10/20.
//

import Foundation
import Domain
import Util

public class CoinRepository: CoinRepositoryProtocol {

    public init() {}

    /// 코인리스트 가져오기
    public func fetchCoinList(completion: @escaping ([Coin]) -> Void) {
        CoinAPI.reqFetchCoinList(){ result in
            switch result {
            case .success(let list):
                Log.d(list.first!)
                completion(list)
            case .failure(let error):
                Log.e(error.localizedDescription)
            }
        }
    }
}
