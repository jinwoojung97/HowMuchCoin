//
//  entryView.swift
//  Presentation
//
//  Created by inforex on 2022/10/24.
//

import Foundation
import UIKit

import Util

import SnapKit
import Then

/// 항목별로 비율이 나뉘어져 있음
public final class EntryView: UIView {
    let rankView = UIView().then {
        $0.backgroundColor = .clear
    }

    let nameView = UIView().then {
        $0.backgroundColor = .clear
    }

    let priceView = UIView().then {
        $0.backgroundColor = .clear
    }

    let percentChangeView = UIView().then {
        $0.backgroundColor = .clear
    }

    let optionView = UIView().then {
        $0.backgroundColor = .clear
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }

    private func initialize(){
        addComponent()
        setConstraints()
    }

    private func addComponent(){
        [rankView, nameView, priceView, percentChangeView, optionView].forEach(self.addSubview)
    }

    private func setConstraints(){
        // MARK: - View
        rankView.snp.makeConstraints{
            $0.top.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(Entry.rank.widthRatio)
            $0.leading.equalToSuperview()
        }

        nameView.snp.makeConstraints{
            $0.top.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(Entry.name.widthRatio)
            $0.leading.equalTo(rankView.snp.trailing)
        }

        priceView.snp.makeConstraints{
            $0.top.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(Entry.price.widthRatio)
            $0.leading.equalTo(nameView.snp.trailing)
        }

        percentChangeView.snp.makeConstraints{
            $0.top.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(Entry.percentChange.widthRatio)
            $0.leading.equalTo(priceView.snp.trailing)
        }

        optionView.snp.makeConstraints{
            $0.top.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(Entry.option.widthRatio)
            $0.leading.equalTo(percentChangeView.snp.trailing)
        }
    }
}

private enum Entry{
    case rank
    case name
    case price
    case percentChange
    case option

    public var widthRatio: Double{
        switch self{
        case .rank: return 0.08
        case .name: return 0.285
        case .price: return 0.285
        case .percentChange: return 0.175
        case .option: return 0.175
        }
    }
}
