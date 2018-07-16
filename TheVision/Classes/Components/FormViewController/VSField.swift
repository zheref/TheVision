//
//  Field.swift
//  Vision
//
//  Created by Sergio Daniel L. García on 6/8/18.
//  Copyright © 2018 Sergio Lozano García. All rights reserved.
//

import Foundation

public struct VSField {
    // MARK: - Stored properties
    
    public var name: String
    
    var title: String
    var type: VSFieldType
    var size: VSFieldSize
    var options: VSFieldOptions?
    
    // MARK: - Initializers
    
    public init(name: String,
                title: String,
                type: VSFieldType) {
        self.init(name: name, title: title, type: type, size: .regular)
    }
    
    public init(name: String,
                title: String,
                type: VSFieldType,
                size: VSFieldSize,
                options: VSFieldOptions? = nil) {
        self.name = name
        self.title = title
        self.type = type
        self.size = size
        self.options = options
    }
}
