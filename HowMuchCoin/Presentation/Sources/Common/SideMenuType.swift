//
//  SideMenuType.swift
//  Presentation
//
//  Created by inforex on 2022/10/26.
//

import Foundation

public enum SideMenuType {
    case percentChange
    case option

    public var menus: [SortBy]{
        switch self{
        case .percentChange:
            return [.percentChange1HAsc,
                    .percentChange1HDesc,
                    .percentChange24HAsc,
                    .percentChange24HDesc,
                    .percentChange7DAsc,
                    .percentChange7DDesc]
        case .option:
            return [.marketCapAsc,
                    .marketCapDesc,
                    .volume24HAsc,
                    .volume24HDesc]
        }
    }
}
