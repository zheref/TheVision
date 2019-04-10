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
    
    open func addShadow(withColor color: UIColor, andRadius shadowRadius: CGFloat, andOffset shadowOffset: CGSize, andOpacity shadowOpacity: Float) -> UIView {
        let shadow = UIView(frame: CGRect.zero)
        shadow.isUserInteractionEnabled = false
        shadow.layer.shadowColor = color.cgColor
        shadow.layer.shadowOffset = shadowOffset
        shadow.layer.shadowRadius = shadowRadius
        shadow.layer.masksToBounds = false
        shadow.clipsToBounds = false
        shadow.layer.shadowOpacity = shadowOpacity
        
        superview?.insertSubview(shadow, belowSubview: self)
        shadow.addSubview(self)
        return shadow
    }
    
    open func round(withCorderRadius cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
    }
    
//    - (UIView*)putView:(UIView*)view insideShadowWithColor:(UIColor*)color andRadius:(CGFloat)shadowRadius andOffset:(CGSize)shadowOffset andOpacity:(CGFloat)shadowOpacity
//    {
//    CGRect shadowFrame; // Modify this if needed
//    shadowFrame.size.width = 0.f;
//    shadowFrame.size.height = 0.f;
//    shadowFrame.origin.x = 0.f;
//    shadowFrame.origin.y = 0.f;
//    UIView * shadow = [[UIView alloc] initWithFrame:shadowFrame];
//    shadow.userInteractionEnabled = NO; // Modify this if needed
//    shadow.layer.shadowColor = color.CGColor;
//    shadow.layer.shadowOffset = shadowOffset;
//    shadow.layer.shadowRadius = shadowRadius;
//    shadow.layer.masksToBounds = NO;
//    shadow.clipsToBounds = NO;
//    shadow.layer.shadowOpacity = shadowOpacity;
//    [view.superview insertSubview:shadow belowSubview:view];
//    [shadow addSubview:view];
//    return shadow;
//    }
    
}
