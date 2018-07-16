//
//  FormSymbols.swift
//  Vision
//
//  Created by Sergio Daniel L. García on 6/7/18.
//  Copyright © 2018 Sergio Lozano García. All rights reserved.
//

import Foundation

public enum VSFieldSize {
    case regular
    case medium
    case big
}

public typealias VSFieldValues = [String: Any?]

public typealias VSFormOptions = [VSFormOption: Any]

public enum VSFormOption {
    case presentation
    case mode
    case actionCopy
    case navTitle
    case image
    case theme
}

public enum VSFormPresentation {
    case push
    case modal
}

public enum VSFormTheme {
    case light
    case dark
}

public enum VSFormMode {
    case new
    case edit
    case editDelete
    case view
    case action
}

public enum VSFieldOption {
    case placeholder
    case keyboardColor
    case hasClearButton
    case action
    case isEnabled
}

public typealias VSFieldOptions = [VSFieldOption: Any]

protocol FormFieldProtocol {
    
    var currentSavedValue: Any? { get }
    
}
