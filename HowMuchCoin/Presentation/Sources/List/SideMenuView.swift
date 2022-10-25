//
//  SideMenuView.swift
//  Presentation
//
//  Created by inforex on 2022/10/25.
//

import Foundation
import UIKit

import Util

import SnapKit
import Then
import RxSwift
import RxGesture

public final class SideMenuView: UIView {

    var type : SideMenuType!

    let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.backgroundColor = .dynamicGray
    }

    required init(frame: CGRect, type: SideMenuType) {
        super.init(frame: frame)
        self.type = type
        initialize()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }

    func initialize(){
        addComponent()
        setConstraints()
        makeMenus()
    }

    func addComponent(){
        self.addSubview(stackView)
    }

    func setConstraints(){
        stackView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    func makeMenus(){
        type.menus.forEach{ menu in
            let sideMenu = SideMenu(frame: .zero, menu: menu)
            stackView.addArrangedSubview(sideMenu)

            sideMenu.snp.makeConstraints{
                $0.height.equalTo(30)
            }
        }
    }
}

public enum SideMenuType {
    case percentChange
    case option

    var menus: [SortBy]{
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

public final class SideMenu: UIView {

    var menu : SortBy!
    var disposeBag = DisposeBag()
    var menuTapped : PublishSubject<SortBy> = .init()

    let label = UILabel().then {
        $0.font = .systemFont(ofSize: 13, weight: .bold)
        $0.textColor = .dynamicLabel
        $0.textAlignment = .center
    }

    required init(frame: CGRect, menu: SortBy) {
        super.init(frame: frame)
        self.menu = menu
        initialize()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }

    func initialize(){
        self.addSubview(label)

        label.snp.makeConstraints{
            $0.center.equalToSuperview()
        }

        label.text = menu.word

        self.rx.tapGesture()
            .when(.recognized)
            .bind{ _ in
                Log.d(self.menu.word)
            }.disposed(by: disposeBag)
    }
}

public enum SortBy {
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

    var word: String{
        switch self{
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
