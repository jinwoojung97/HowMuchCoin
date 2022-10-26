//
//  CoinCell.swift
//  Presentation
//
//  Created by inforex on 2022/10/24.
//

import Foundation
import UIKit

import Util
import Domain

import SnapKit
import Then

public final class CoinCell: UITableViewCell{
    static let identifier = description()

    let entryView = EntryView().then {
        $0.backgroundColor = .clear
    }

    let rankingLabel = UILabel().then{
        $0.font = .systemFont(ofSize: 13, weight: .medium)
        $0.textColor = .dynamicLabel
        $0.textAlignment = .center
    }

    let nameLabel = UILabel().then{
        $0.font = .systemFont(ofSize: 15, weight: .semibold)
        $0.textColor = .dynamicLabel
        $0.textAlignment = .left
    }

    let symbolLabel = UILabel().then{
        $0.font = .systemFont(ofSize: 11, weight: .medium)
        $0.textColor = .systemGray
        $0.textAlignment = .left
    }

    let priceLabel = UILabel().then{
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.textColor = .systemRed
        $0.textAlignment = .right
    }

    /// 전일대비(24h)(default), 전주대비(7d), 전시간대비(1H)
    let percentChangeLabel = UILabel().then{
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.textColor = .systemRed
        $0.textAlignment = .right
    }

    /// 거래량(default), 총 시가
    let optionLabel = UILabel().then{
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.textColor = .dynamicLabel
        $0.textAlignment = .right
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initialize() {
        self.selectionStyle = .none
        addComponent()
        setConstraints()
    }

    private func addComponent() {
        contentView.addSubview(entryView)

        entryView.rankView.addSubview(rankingLabel)
        entryView.nameView.addSubview(nameLabel)
        entryView.nameView.addSubview(symbolLabel)
        entryView.priceView.addSubview(priceLabel)
        entryView.percentChangeView.addSubview(percentChangeLabel)
        entryView.optionView.addSubview(optionLabel)
    }

    private func setConstraints() {
        entryView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }

        rankingLabel.snp.makeConstraints{
            $0.center.equalToSuperview()
        }

        nameLabel.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview().inset(8)
        }

        symbolLabel.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.top.equalTo(nameLabel.snp.bottom)
        }

        priceLabel.snp.makeConstraints{
            $0.centerY.trailing.equalToSuperview()
            
        }

        percentChangeLabel.snp.makeConstraints{
            $0.centerY.trailing.equalToSuperview()
        }

        optionLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(6)
        }
    }

    func dataBind(coin: Coin, sortBy: SortBy) {
        let percentChangeValue : Double
        let optionValue : Double

        switch sortBy{
        case .initialState, .percentChange24HAsc, .percentChange24HDesc,
                .volume24HAsc, .volume24HDesc:
            percentChangeValue = coin.quotes.priceInfo.percentChange24h
            optionValue = coin.quotes.priceInfo.volume24h
        case .percentChange1HAsc, .percentChange1HDesc:
            percentChangeValue = coin.quotes.priceInfo.percentChange1h
            optionValue = coin.quotes.priceInfo.volume24h
        case .percentChange7DAsc, .percentChange7DDesc:
            percentChangeValue = coin.quotes.priceInfo.percentChange7d
            optionValue = coin.quotes.priceInfo.volume24h
        case .marketCapAsc, .marketCapDesc:
            percentChangeValue = coin.quotes.priceInfo.percentChange1h
            optionValue = coin.quotes.priceInfo.marketCap
        }

        /// Text Setting
        percentChangeLabel.text = "\(percentChangeValue)%"
        optionLabel.text = optionValue.trillionFormatter()
        nameLabel.text = "\(coin.name)"
        symbolLabel.text = "\(coin.symbol)/KRW"
        priceLabel.text = coin.quotes.priceInfo.price.numberFormatter()

        /// Text Color Setting
        let textColor: UIColor = percentChangeValue > 0 ? .systemRed : .systemBlue
        [priceLabel, percentChangeLabel].forEach{
            $0.textColor = textColor
        }
    }
}
