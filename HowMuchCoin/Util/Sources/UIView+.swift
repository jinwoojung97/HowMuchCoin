//
//  UIView+.swift
//  Util
//
//  Created by inforex on 2022/10/21.
//

import Foundation
import UIKit

public extension UIView{
    /// CornerRadius
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11.0, *) {
            clipsToBounds = true
            layer.cornerRadius = radius
            layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
        } else {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }

    ///Show and Animation
    func animShow(_ duration: TimeInterval = 0.35, completion: ((Bool)->Void)? = nil){
        UIView.animate(withDuration: duration, delay: 0, options: [],
                       animations: {
            self.isHidden = false
        },  completion: { _ in })
    }

    /// Hide and Animation
    func animHide(_ duration: TimeInterval = 0.35, completion: ((Bool)->Void)? = nil){
        UIView.animate(withDuration: duration, delay: 0, options: [],
                       animations: {
            self.isHidden = true
        },  completion: { _ in })
    }
}
