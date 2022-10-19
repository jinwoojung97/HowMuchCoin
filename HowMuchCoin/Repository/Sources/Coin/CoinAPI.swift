//
//  CoinAPI.swift
//  Repository
//
//  Created by inforex on 2022/10/19.
//

import Foundation
import Moya
import Util
import Domain

struct CoinAPI: Networkable{
    /// Target  지정
    typealias Target = CoinTargetType

    /// 코인리스트 불러오기
    static func reqFetchCoinList(completion: @escaping (Result<[Coin], Error>) -> Void) {
        makeProvider().request(.reqMarketPriceList) { result in
            /// 특정 모델타입(Coin)으로 디코딩
            switch ResponseData<[Coin]>.processModelResponse(result) {
            case .success(let model):
                guard let model = model else { return }
                let top100List = Array(model[..<99])
                return completion(.success(top100List))
            case .failure(let error):
                return completion(.failure(error))
            }
        }
    }
}
