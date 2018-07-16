//
//  DropdownPickerBaseCell.swift
//  TheVision
//
//  Created by Sergio Daniel L. García on 7/4/18.
//

import Foundation

open class VSDropdownPickerBaseCell : UITableViewCell, VSDropdownPickerCellProtocol {
    
    open func configureData(_ data: VSDropdownPickerItemData) {
        self.textLabel?.text = data.title
    }
    
    func configureStyle(_ config: VSDropdownPickerConfig) {
        self.selectionStyle = .none
        self.backgroundColor = config.itemColor
        self.textLabel?.textColor = config.itemFontColor
        self.textLabel?.font = UIFont(name: config.itemFont, size: config.itemFontSize)
        
        switch config.itemAlignment {
        case .left:
            self.textLabel?.textAlignment = .left
        case .right:
            self.textLabel?.textAlignment = .right
        case .center:
            self.textLabel?.textAlignment = .center
        }
    }
}

protocol VSDropdownPickerCellProtocol {
    func configureData(_ data: VSDropdownPickerItemData)
    func configureStyle(_ configuration: VSDropdownPickerConfig)
}

public enum VSDropdownPickerItemAlignment {
    case left, right, center
}
