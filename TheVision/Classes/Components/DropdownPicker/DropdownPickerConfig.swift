//
//  DropdownPickerConfig.swift
//  TheVision
//
//  Created by Sergio Daniel L. García on 7/5/18.
//

import Foundation

struct VSDropdownPickerConfig {
    
    var itemColor : UIColor = UIColor.white
    var itemSelectionColor : UIColor = UIColor.lightGray
    var itemAlignment : VSDropdownPickerItemAlignment = .left
    var itemFontColor : UIColor = UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0)
    var itemFontSize : CGFloat = 14.0
    var itemFont : String = "Helvetica"
    var overlayAlpha : CGFloat = 0.5
    var overlayColor : UIColor = UIColor.black
    var menuSeparatorStyle : VSDropdownPickerSeparatorStyle = .singleline
    var menuSeparatorColor : UIColor = UIColor.lightGray
    var itemImagePosition : VSDropdownPickerItemImagePosition = .prefix
    var shouldDismissMenuOnDrag : Bool = false
}

/**
 The separator style of the menu
 
 - Singleline: A solid single line
 - None:       No Separator
 */
public enum VSDropdownPickerSeparatorStyle {
    case singleline, none
}

/**
 The position of image icon in the menu
 
 - Prefix:  Place icon before item title
 - Postfix: Place icon after item title
 */
public enum VSDropdownPickerItemImagePosition {
    case prefix, postfix
}
