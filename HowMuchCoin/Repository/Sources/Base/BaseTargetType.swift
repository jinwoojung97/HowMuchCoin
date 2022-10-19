//
//  BaseTargetType.swift
//  Repository
//
//  Created by inforex on 2022/10/19.
//

import Foundation
import Moya

protocol BaseTargetType: TargetType {}

extension BaseTargetType {

    /// 공통 HTTP header 정의
    ///  return ["Content-type": "application/json"]
    public var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }

    /// BaseTargetType을 상속받는 각 TargetType에서 sampleData를 필수로 구현하지 않아도 되도록 디폴트값 부여
    var sampleData: Data {
        return Data()
    }
}
