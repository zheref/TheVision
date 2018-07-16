//
//  FormSymbols.swift
//  Vision
//
//  Created by Sergio Daniel L. García on 6/7/18.
//  Copyright © 2018 Sergio Lozano García. All rights reserved.
//

import Foundation

public enum XVSFieldSize {
    case regular
    case medium
    case big
}

public typealias XVSFieldValues = [String: Any?]

public typealias XVSFormOptions = [XVSFormOption: Any]

public enum XVSFormOption {
    case presentation
    case mode
    case actionCopy
    case navTitle
    case image
    case theme
}

public enum XVSFormPresentation {
    case push
    case modal
}

public enum XVSFormTheme {
    case light
    case dark
}

public enum XVSFormMode {
    case new
    case edit
    case editDelete
    case view
    case action
}

public enum XVSFieldOption {
    case placeholder
    case keyboardColor
    case hasClearButton
    case action
    case isEnabled
}

public typealias XVSFieldOptions = [XVSFieldOption: Any]

protocol FormFieldProtocol {
    
    var currentSavedValue: Any? { get }
    
}
