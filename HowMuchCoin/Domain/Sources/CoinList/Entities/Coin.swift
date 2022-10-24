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
    public var symbol: String // Symbol
    public var quotes: Quotes

    enum CodingKeys: String, CodingKey{
        case id
        case name
        case rank
        case symbol
        case quotes
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        rank = try container.decode(Int.self, forKey: .rank)
        symbol = try container.decode(String.self, forKey: .symbol)
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
    public var marketCap: Double // 총 시가
    public var volume24h: Double // 거래량(24h)
    public var percentChange1h: Double // 변동(1h)
    public var percentChange24h: Double // 변동(24h)
    public var percentChange7d: Double // 변동(7d)

    enum CodingKeys: String, CodingKey{
        case price
        case marketCap = "market_cap"
        case volume24h = "volume_24h"
        case percentChange1h = "percent_change_1h"
        case percentChange24h = "percent_change_24h"
        case percentChange7d = "percent_change_7d"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        price = try container.decode(Double.self, forKey: .price).decimalRound()
        marketCap = try container.decode(Double.self, forKey: .marketCap).decimalRound()
        volume24h = try container.decode(Double.self, forKey: .volume24h).decimalRound()
        percentChange1h = try container.decode(Double.self, forKey: .percentChange1h).decimalRound()
        percentChange24h = try container.decode(Double.self, forKey: .percentChange24h).decimalRound()
        percentChange7d = try container.decode(Double.self, forKey: .percentChange7d).decimalRound()
    }
}
