//
//  CoinTargetType.swift
//  Repository
//
//  Created by inforex on 2022/10/19.
//

import Foundation
import Moya

enum CoinTargetType {
    case reqMarketPriceList // Top100 코인리스트
}

extension CoinTargetType: BaseTargetType {
    var baseURL: URL {
        return URL(string: NetworkURL.coinUrl)!
    }

    var path: String {
        switch self {
        case .reqMarketPriceList:
            return "/tickers"
        }
    }

    var method: Moya.Method {
        switch self {
        case .reqMarketPriceList:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .reqMarketPriceList:
            let params: [String: Any] = [
                "quotes": "KRW"
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        }
    }
}
