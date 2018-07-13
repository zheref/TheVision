//
//  UIView+SafeArea.swift
//  TheVision
//
//  Created by Sergio Daniel L. García on 7/9/18.
//

import Foundation

extension UIView {
    
    open var safeAreaTopHeight: CGFloat? {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.keyWindow?.safeAreaInsets.top
        } else {
            return 0.0
        }
    }
    
    open var safeAreaBottomHeight: CGFloat? {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.keyWindow?.safeAreaInsets.bottom
        } else {
            return 0.0
        }
    }
    
}
