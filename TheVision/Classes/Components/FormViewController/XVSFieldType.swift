//
//  FieldType.swift
//  Vision
//
//  Created by Sergio Daniel L. García on 6/8/18.
//  Copyright © 2018 Sergio Lozano García. All rights reserved.
//

import Foundation

public enum XVSFieldType {
    
    // Text
    case name
    case text
    case password
    case email
    case phoneNumber
    
    // Number
    case short
    case slider
    case number
    case money
    
    case date
    case time
    case datetime
    
    case options
    case countries
    case timezones
    case currencies
    
    // Action
    
    case cta
    case action
    case deleteAction
}
