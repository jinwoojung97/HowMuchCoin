//
//  SortBt.swift
//  Presentation
//
//  Created by inforex on 2022/10/26.
//

import Foundation

public enum SortBy {
    case initialState
    /*
     percentChange
     */
    case percentChange1HAsc
    case percentChange1HDesc
    case percentChange24HAsc
    case percentChange24HDesc
    case percentChange7DAsc
    case percentChange7DDesc

    /*
     option
     */
    case marketCapAsc
    case marketCapDesc
    case volume24HAsc
    case volume24HDesc

    public var word: String{
        switch self{
        case .initialState: return ""
        case .percentChange1HAsc: return "전시간대비-"
        case .percentChange1HDesc: return "전시간대비+"
        case .percentChange24HAsc: return "전일대비-"
        case .percentChange24HDesc: return "전일대비+"
        case .percentChange7DAsc: return "전주대비-"
        case .percentChange7DDesc: return "전주대비+"
        case .marketCapAsc: return "총 시가-"
        case .marketCapDesc: return "총 시가+"
        case .volume24HAsc: return "거래액(1D)-"
        case .volume24HDesc: return "거래액(1D)+"
        }
    }
}
