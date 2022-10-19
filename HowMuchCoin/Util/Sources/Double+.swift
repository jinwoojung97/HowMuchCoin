//
//  Double+.swift
//  Util
//
//  Created by inforex on 2022/10/19.
//

import Foundation

extension Double{
    /// 소수점 둘쨋자리 까지 반올림
    public func decimalRound() -> Double {
        let digit: Double = pow(10, 2)

        return (self * digit).rounded() / digit
    }
}
