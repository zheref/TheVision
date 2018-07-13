//
//  DropdownPickerBaseCell.swift
//  TheVision
//
//  Created by Sergio Daniel L. García on 7/4/18.
//

import Foundation

open class TVSDropdownPickerBaseCell : UITableViewCell, TVSDropdownPickerCellProtocol {
    
    open func configureData(_ data: TVSDropdownPickerItemData) {
        self.textLabel?.text = data.title
    }
    
    func configureStyle(_ config: TVSDropdownPickerConfig) {
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

protocol TVSDropdownPickerCellProtocol {
    func configureData(_ data: TVSDropdownPickerItemData)
    func configureStyle(_ configuration: TVSDropdownPickerConfig)
}

public enum TVSDropdownPickerItemAlignment {
    case left, right, center
}
