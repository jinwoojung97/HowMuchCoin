//
//  Coin.swift
//  Repository
//
//  Created by inforex on 2022/10/19.
//

import Foundation
import Util


public struct Coin: Codable{
    public var id: String // id
    public var name: String // 종목
    public var rank: Int // Rank
    public var quotes: Quotes

    enum CodingKeys: String, CodingKey{
        case id
        case name
        case rank
        case quotes
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        rank = try container.decode(Int.self, forKey: .rank)
        quotes = try container.decode(Quotes.self, forKey: .quotes)
    }
}

public struct Quotes: Codable{
    public var priceInfo: PriceInfo

    enum CodingKeys: String, CodingKey{
        case priceInfo = "KRW"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        priceInfo = try container.decode(PriceInfo.self, forKey: .priceInfo)
    }
}


public struct PriceInfo: Codable {
    public var price: Double // 현재 가격
    public var market_cap: Double // 총 시가
    public var volume_24h: Double // 거래량(24h)
    public var percent_change_24h: Double // 변동(24h)
    public var percent_change_7d: Double // 변동(7d)

    enum CodingKeys: String, CodingKey{
        case price
        case market_cap
        case volume_24h
        case percent_change_24h
        case percent_change_7d
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        price = try container.decode(Double.self, forKey: .price).decimalRound()
        market_cap = try container.decode(Double.self, forKey: .market_cap).decimalRound()
        volume_24h = try container.decode(Double.self, forKey: .volume_24h).decimalRound()
        percent_change_24h = try container.decode(Double.self, forKey: .percent_change_24h).decimalRound()
        percent_change_7d = try container.decode(Double.self, forKey: .percent_change_7d).decimalRound()
    }
}
