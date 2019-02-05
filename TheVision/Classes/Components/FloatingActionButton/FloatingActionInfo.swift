//
//  FloatingActionInfo.swift
//  TheVision
//
//  Created by Sergio Daniel on 1/15/19.
//

import Foundation

public enum VSFloatingActionPosition {
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight
}

public struct VSFloatingActionInfo {
    
    struct Defaults {
        static let frame = CGRect(x: 22.0, y: 53.0, width: 50.0, height: 50.0)
    }
    
    public var frame: CGRect = Defaults.frame
    var iconImage: UIImage?
    var position: VSFloatingActionPosition = .topLeft
    
    public init(iconImage: UIImage?, position: VSFloatingActionPosition = .topLeft) {
        self.iconImage = iconImage
        self.position = position
    }
    
}
