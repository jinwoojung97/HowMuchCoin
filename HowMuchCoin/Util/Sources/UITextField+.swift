//
//  UITextField+.swift
//  Util
//
//  Created by inforex on 2022/10/21.
//

import Foundation
import UIKit

public extension UITextField {
    func addLeftPadding() {
      let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
      self.leftView = paddingView
      self.leftViewMode = ViewMode.always
    }
}
