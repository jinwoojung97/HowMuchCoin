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
    var menuTapped : PublishSubject<SortBy> = .init()

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

    private func initialize(){
        addComponent()
        setConstraints()
        makeMenus()
    }

    private func addComponent(){
        self.addSubview(stackView)
    }

    private func setConstraints(){
        stackView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    private func makeMenus(){
        type.menus.forEach{[weak self] menu in
            let sideMenu = SideMenu(frame: .zero, menu: menu)
            stackView.addArrangedSubview(sideMenu)

            sideMenu.snp.makeConstraints{
                $0.height.equalTo(30)
            }

            sideMenu.tapAction = { tapMenu in
                self?.menuTapped.onNext(tapMenu)
            }
        }
    }
}

public final class SideMenu: UIView {

    var menu : SortBy!
    var disposeBag = DisposeBag()
    var tapAction : ((SortBy) -> Void)?

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
            .bind{[weak self] _ in
                guard let self = self else { return }
                self.tapAction?(self.menu)
            }.disposed(by: disposeBag)
    }
}
