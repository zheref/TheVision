//
//  FieldCellDelegate.swift
//  XVision
//
//  Created by Sergio Lozano García on 6/16/18.
//  Copyright © 2018 Sergio Lozano García. All rights reserved.
//

import Foundation

protocol FieldCellDelegate : class {
    
    func cell(forField field: XVSField, changedToValue value: Any?)
    
}
