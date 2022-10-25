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
    
    public func decimalRound(_ num: Double) -> Double {
        let digit: Double = pow(10, num)

        return (self * digit).rounded() / digit
    }

    /// 조 단위 반환
    public func trillionFormatter() -> String {
        return "\((self / 1000000000000).decimalRound())T"
    }

    /// 1000 단위 (,) 넣기
    public func numberFormatter() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(from: NSNumber(value: self))!
    }
}
