//
//  Repository.swift
//  ProjectDescriptionHelpers
//
//  Created by inforex on 2022/10/14.
//

import Foundation
import Moya
import Util
import SwiftyJSON
import Domain

public class RepositoryTest{
    public init() {
        /// api 요청 예시
        CoinAPI.reqFetchCoinList(){ result in
            switch result {
            case .success(let list):
                Log.d(list.first!)
            case .failure(let error):
                Log.e(error.localizedDescription)
            }
        }
    }
}
