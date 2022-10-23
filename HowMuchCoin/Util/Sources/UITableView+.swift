//
//  UITableView+.swift
//  Util
//
//  Created by inforex on 2022/10/21.
//

import Foundation
import UIKit

public extension UITableView {
    /// TableView HeaderView 의 높이가 변경됐을 때 HeaderView를 Update
    func setAndLayoutTableHeaderView(header: UIView) {
        self.tableHeaderView = header
        self.tableHeaderView?.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            header.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
        header.setNeedsLayout()
        header.layoutIfNeeded()
        header.frame.size =  header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        self.tableHeaderView = header
    }
}
